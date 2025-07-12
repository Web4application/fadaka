/**
 * Methods for the Bitswap exchange
 */
#include <stdlib.h>
#include <unistd.h> // for sleep()
#include <pthread.h>
#include "libp2p/os/utils.h"
#include "libp2p/utils/logger.h"
#include "libp2p/net/stream.h"
#include "libp2p/net/connectionstream.h"
#include "ipfs/core/ipfs_node.h"
#include "ipfs/datastore/ds_helper.h"
#include "ipfs/exchange/exchange.h"
#include "ipfs/exchange/bitswap/bitswap.h"
#include "ipfs/exchange/bitswap/message.h"
#include "ipfs/exchange/bitswap/network.h"
#include "ipfs/exchange/bitswap/peer_request_queue.h"
#include "ipfs/exchange/bitswap/want_manager.h"

int ipfs_bitswap_can_handle(const struct StreamMessage* msg) {
	if (msg == NULL || msg->data == NULL || msg->data_size == 0)
		return 0;
	char* result = strnstr((char*)msg->data, "/ipfs/bitswap", msg->data_size);
	if(result == NULL || result != (char*)msg->data)
		return 0;
	return 1;
}

int ipfs_bitswap_shutdown_handler(void* context) {
	return 1;
}

/***
 * Handles the message
 * @param incoming the incoming data buffer
 * @param incoming_size the size of the incoming data buffer
 * @param session_context the information about the incoming connection
 * @param protocol_context the protocol-dependent context
 * @returns 0 if the caller should not continue looping, <0 on error, >0 on success
 */
int ipfs_bitswap_handle_message(const struct StreamMessage* msg, struct Stream* stream, void* protocol_context) {
	struct IpfsNode* local_node = (struct IpfsNode*)protocol_context;
	struct SessionContext* session_context = libp2p_net_connection_get_session_context(stream);
	if (session_context == NULL)
		return -1;
	int retVal = ipfs_bitswap_network_handle_message(local_node, session_context, msg->data, msg->data_size);
	if (retVal == 0)
		return -1;
	return retVal;
}

struct Libp2pProtocolHandler* ipfs_bitswap_build_protocol_handler(const struct IpfsNode* local_node) {
	struct Libp2pProtocolHandler* handler = (struct Libp2pProtocolHandler*) malloc(sizeof(struct Libp2pProtocolHandler));
	if (handler != NULL) {
		handler->context = (void*)local_node;
		handler->CanHandle = ipfs_bitswap_can_handle;
		handler->HandleMessage = ipfs_bitswap_handle_message;
		handler->Shutdown = ipfs_bitswap_shutdown_handler;
	}
	return handler;
}

/**
 * Create a new bitswap exchange
 * @param sessionContext the context
 * @returns an allocated Exchange structure
 */
struct Exchange* ipfs_bitswap_new(struct IpfsNode* ipfs_node) {
	struct Exchange* exchange = (struct Exchange*) malloc(sizeof(struct Exchange));
	if (exchange != NULL) {
		struct BitswapContext* bitswapContext = (struct BitswapContext*) malloc(sizeof(struct BitswapContext));
		if (bitswapContext == NULL) {
			free(exchange);
			return NULL;
		}
		bitswapContext->bitswap_engine = ipfs_bitswap_engine_new();
		if (bitswapContext->bitswap_engine == NULL) {
			free(bitswapContext);
			free(exchange);
			return NULL;
		}
		bitswapContext->localWantlist = ipfs_bitswap_wantlist_queue_new();
		bitswapContext->peerRequestQueue = ipfs_bitswap_peer_request_queue_new();
		bitswapContext->ipfsNode = ipfs_node;

		exchange->exchangeContext = (void*) bitswapContext;
		exchange->IsOnline = ipfs_bitswap_is_online;
		exchange->Close = ipfs_bitswap_close;
		exchange->HasBlock = ipfs_bitswap_has_block;
		exchange->GetBlock = ipfs_bitswap_get_block;
		exchange->GetBlockAsync = ipfs_bitswap_get_block_async;
		exchange->GetBlocks = ipfs_bitswap_get_blocks;

		// Start the threads for the network
		ipfs_bitswap_engine_start(bitswapContext);
		libp2p_logger_debug("bitswap", "Bitswap engine started\n");
	}
	return exchange;
}

/**
 * Clean up resources within an Exchange struct
 * @param exchange the exchange to free
 * @returns true(1)
 */
int ipfs_bitswap_free(struct Exchange* exchange) {
	if (exchange != NULL) {
		if (exchange->exchangeContext != NULL) {
			struct BitswapContext* bitswapContext = (struct BitswapContext*) exchange->exchangeContext;
			if (bitswapContext != NULL)
				ipfs_bitswap_engine_stop(bitswapContext);
			if (bitswapContext->localWantlist != NULL) {
				ipfs_bitswap_wantlist_queue_free(bitswapContext->localWantlist);
				bitswapContext->localWantlist = NULL;
			}
			if (bitswapContext->peerRequestQueue != NULL) {
				ipfs_bitswap_peer_request_queue_free(bitswapContext->peerRequestQueue);
				bitswapContext->peerRequestQueue = NULL;
			}
			free(exchange->exchangeContext);
		}
		free(exchange);
	}
	return 1;
}

/**
 * Implements the Exchange->IsOnline method
 */
int ipfs_bitswap_is_online(struct Exchange* exchange) {
	return 1;
}

/***
 * Implements the Exchange->Close method
 */
int ipfs_bitswap_close(struct Exchange* exchange) {
	ipfs_bitswap_free(exchange);
	return 0;
}

/**
 * Implements the Exchange->HasBlock method
 * Some notes from the GO version say that this is normally called by user
 * interaction (i.e. user added a file).
 * But this does not make sense right now, as the GO code looks like it
 * adds the block to the blockstore. This still has to be sorted.
 */
int ipfs_bitswap_has_block(struct Exchange* exchange, struct Block* block) {
	// add the block to the blockstore
	struct BitswapContext* context = exchange->exchangeContext;
	size_t bytes_written;
	context->ipfsNode->blockstore->Put(context->ipfsNode->blockstore->blockstoreContext, block, &bytes_written);
	// add it to the datastore
	ipfs_datastore_helper_add_block_to_datastore(block, context->ipfsNode->repo->config->datastore);
	// update requests
	struct WantListQueueEntry* queueEntry = ipfs_bitswap_wantlist_queue_find(context->localWantlist, block->cid);
	if (queueEntry != NULL) {
		queueEntry->block = block;
	}
	// TODO: Announce to world that we now have the block
	return 0;
}

/**
 * Implements the Exchange->GetBlock method
 * We're asking for this method to get the block from peers. Perhaps this should be
 * taking in a pointer to a callback, as this could take a while (or fail).
 * @param exchangeContext a BitswapContext
 * @param cid the Cid to look for
 * @param block a pointer to where to put the result
 * @returns true(1) if found, false(0) if not
 */
int ipfs_bitswap_get_block(struct Exchange* exchange, struct Cid* cid, struct Block** block) {
	struct BitswapContext* bitswapContext = (struct BitswapContext*)exchange->exchangeContext;
	if (bitswapContext != NULL) {
		// check locally first
		if (bitswapContext->ipfsNode->blockstore->Get(bitswapContext->ipfsNode->blockstore->blockstoreContext, cid, block))
			return 1;
		// now ask the network
		//NOTE: this timeout should be configurable
		int timeout = 60;
		int waitSecs = 1;
		int timeTaken = 0;
		struct WantListSession *wantlist_session = ipfs_bitswap_wantlist_session_new();
		wantlist_session->type = WANTLIST_SESSION_TYPE_LOCAL;
		wantlist_session->context = (void*)bitswapContext->ipfsNode;
		struct WantListQueueEntry* want_entry = ipfs_bitswap_want_manager_add(bitswapContext, cid, wantlist_session);
		if (want_entry != NULL) {
			// loop waiting for it to fill
			while(1) {
				if (want_entry->block != NULL) {
					*block = ipfs_block_copy(want_entry->block);
					// error or not, we no longer need the block (decrement reference count)
					ipfs_bitswap_want_manager_remove(bitswapContext, cid);
					if (*block == NULL) {
						return 0;
					}
					return 1;
				}
				//TODO: This is a busy-loop. Find another way.
				timeTaken += waitSecs;
				if (timeTaken >= timeout) {
					// It took too long. Stop looking.
					ipfs_bitswap_want_manager_remove(bitswapContext, cid);
					break;
				}
				sleep(waitSecs);
			}
		}
	}
	return 0;
}

/**
 * Implements the Exchange->GetBlock method
 * We're asking for this method to get the block from peers. Perhaps this should be
 * taking in a pointer to a callback, as this could take a while (or fail).
 * @param exchangeContext a BitswapContext
 * @param cid the Cid to look for
 * @param block a pointer to where to put the result
 * @returns true(1) if found, false(0) if not
 */
int ipfs_bitswap_get_block_async(struct Exchange* exchange, struct Cid* cid, struct Block** block) {
	struct BitswapContext* bitswapContext = (struct BitswapContext*)exchange->exchangeContext;
	if (bitswapContext != NULL) {
		// check locally first
		struct Block* block;
		if (bitswapContext->ipfsNode->blockstore->Get(bitswapContext->ipfsNode->blockstore->blockstoreContext, cid, &block)) {
			return 1;
		}
		// now ask the network
		struct WantListSession* wantlist_session = ipfs_bitswap_wantlist_session_new();
		wantlist_session->type = WANTLIST_SESSION_TYPE_LOCAL;
		wantlist_session->context = (void*)bitswapContext->ipfsNode;
		ipfs_bitswap_want_manager_add(bitswapContext, cid, wantlist_session);
		// TODO: return something that they can watch
		return 1;
	}
	return 0;
}

/**
 * Implements the Exchange->GetBlocks method
 */
int ipfs_bitswap_get_blocks(struct Exchange* exchange, struct Libp2pVector* Cids, struct Libp2pVector** blocks) {
	// TODO: Implement this method
	return 0;
}
