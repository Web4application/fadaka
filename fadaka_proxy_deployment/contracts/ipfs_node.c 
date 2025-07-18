#include <stdlib.h>
#include <pthread.h>

#include "libp2p/conn/dialer.h"
#include "libp2p/identify/identify.h"
#include "libp2p/net/multistream.h"
#include "libp2p/utils/vector.h"
#include "libp2p/secio/secio.h"
#include "libp2p/routing/dht_protocol.h"
#include "libp2p/yamux/yamux.h"
#include "ipfs/core/api.h"
#include "ipfs/core/client_api.h"
#include "ipfs/core/ipfs_node.h"
#include "ipfs/exchange/bitswap/bitswap.h"
#include "ipfs/journal/journal.h"

struct IpfsNode* ipfs_node_new() {
	struct IpfsNode* node = malloc(sizeof(struct IpfsNode));
	if (node != NULL) {
		node->blockstore = NULL;
		node->exchange = NULL;
		node->identity = NULL;
		node->mode = MODE_OFFLINE;
		node->peerstore = NULL;
		node->protocol_handlers = NULL;
		node->providerstore = NULL;
		node->repo = NULL;
		node->routing = NULL;
		node->api_context = NULL;
	}
	return node;
}

struct Libp2pVector* ipfs_node_online_build_protocol_handlers(struct IpfsNode* node) {
	struct Libp2pVector* retVal = libp2p_utils_vector_new(1);
	if (retVal != NULL) {
		// secio
		libp2p_utils_vector_add(retVal, libp2p_secio_build_protocol_handler(&node->identity->private_key, node->peerstore));
		// journal
		libp2p_utils_vector_add(retVal, ipfs_journal_build_protocol_handler(node));
		// kademlia
		libp2p_utils_vector_add(retVal, libp2p_routing_dht_build_protocol_handler(node->peerstore, node->providerstore, node->repo->config->datastore, node->repo->config->filestore));
		// bitswap
		libp2p_utils_vector_add(retVal, ipfs_bitswap_build_protocol_handler(node));
		// multistream
		libp2p_utils_vector_add(retVal, libp2p_net_multistream_build_protocol_handler(retVal));
		// yamux
		libp2p_utils_vector_add(retVal, libp2p_yamux_build_protocol_handler());
		// identify
		libp2p_utils_vector_add(retVal, libp2p_identify_build_protocol_handler(node->identity->peer->id, node->identity->peer->id_size));
	}
	return retVal;
}

int ipfs_node_online_protocol_handlers_free(struct Libp2pVector* handlers) {
	for(int i = 0; i < handlers->total; i++) {
		struct Libp2pProtocolHandler* current = (struct Libp2pProtocolHandler*) libp2p_utils_vector_get(handlers, i);
		current->Shutdown(current->context);
		free(current);
	}
	libp2p_utils_vector_free(handlers);
	return 1;
}

/***
 * build an online IpfsNode
 * @param repo_path where the IPFS repository directory is
 * @param node the completed IpfsNode struct
 * @returns true(1) on success
 */
int ipfs_node_online_new(const char* repo_path, struct IpfsNode** node) {
	struct FSRepo* fs_repo = NULL;

	*node = ipfs_node_new();
	if(*node == NULL)
		return 0;

	struct IpfsNode* local_node = *node;

	// build the struct
	if (!ipfs_repo_fsrepo_new(repo_path, NULL, &fs_repo)) {
		ipfs_node_free(local_node);
		*node = NULL;
		return 0;
	}
	// open the repo
	if (!ipfs_repo_fsrepo_open(fs_repo)) {
		ipfs_node_free(local_node);
		*node = NULL;
		return 0;
	}

	// fill in the node
	local_node->repo = fs_repo;
	local_node->identity = fs_repo->config->identity;
	local_node->peerstore = libp2p_peerstore_new(local_node->identity->peer);
	local_node->providerstore = libp2p_providerstore_new(fs_repo->config->datastore, local_node->identity->peer);
	local_node->blockstore = ipfs_blockstore_new(fs_repo);
	local_node->protocol_handlers = ipfs_node_online_build_protocol_handlers(local_node);
	local_node->mode = MODE_OFFLINE;
	local_node->routing = ipfs_routing_new_online(local_node, &fs_repo->config->identity->private_key);
	local_node->exchange = ipfs_bitswap_new(local_node);
	local_node->swarm = libp2p_swarm_new(local_node->protocol_handlers, local_node->repo->config->datastore, local_node->repo->config->filestore);
	local_node->dialer = libp2p_conn_dialer_new(local_node->identity->peer, local_node->peerstore, &local_node->identity->private_key, local_node->swarm);

	// fire up the API
	api_start(local_node, 10, 5);

	return 1;
}

/***
 * build an offline IpfsNode
 * @param repo_path where the IPFS repository directory is
 * @param node the completed IpfsNode struct
 * @returns true(1) on success
 */
int ipfs_node_offline_new(const char* repo_path, struct IpfsNode** node) {
	struct FSRepo* fs_repo = NULL;

	*node = ipfs_node_new();
	if(*node == NULL)
		return 0;

	struct IpfsNode* local_node = *node;

	// build the struct
	if (!ipfs_repo_fsrepo_new(repo_path, NULL, &fs_repo)) {
		ipfs_node_free(local_node);
		*node = NULL;
		return 0;
	}
	// open the repo
	if (!ipfs_repo_fsrepo_open(fs_repo)) {
		ipfs_node_free(local_node);
		*node = NULL;
		return 0;
	}

	// fill in the node
	local_node->repo = fs_repo;
	local_node->identity = fs_repo->config->identity;
	local_node->peerstore = libp2p_peerstore_new(local_node->identity->peer);
	local_node->providerstore = libp2p_providerstore_new(fs_repo->config->datastore, local_node->identity->peer);
	local_node->blockstore = ipfs_blockstore_new(fs_repo);
	local_node->protocol_handlers = ipfs_node_online_build_protocol_handlers(local_node);
	local_node->mode = MODE_OFFLINE;
	local_node->routing = ipfs_routing_new_offline(local_node, &fs_repo->config->identity->private_key);
	local_node->exchange = ipfs_bitswap_new(local_node);
	local_node->swarm = libp2p_swarm_new(local_node->protocol_handlers, local_node->repo->config->datastore, local_node->repo->config->filestore);
	local_node->dialer = libp2p_conn_dialer_new(local_node->identity->peer, local_node->peerstore, &local_node->identity->private_key, local_node->swarm);

	if (api_running(local_node))
		local_node->mode = MODE_API_AVAILABLE;

	return 1;
}

/***
 * Free resources from the creation of an IpfsNode
 * @param node the node to free
 * @returns true(1)
 */
int ipfs_node_free(struct IpfsNode* node) {
	if (node != NULL) {
		if (node->api_context != NULL && node->api_context->api_thread != 0)
			api_stop(node);
		if (node->exchange != NULL) {
			node->exchange->Close(node->exchange);
		}
		if (node->providerstore != NULL)
			libp2p_providerstore_free(node->providerstore);
		if (node->peerstore != NULL)
			libp2p_peerstore_free(node->peerstore);
		if (node->repo != NULL)
			ipfs_repo_fsrepo_free(node->repo);
		if (node->protocol_handlers != NULL)
			ipfs_node_online_protocol_handlers_free(node->protocol_handlers);
		if (node->mode == MODE_ONLINE) {
			ipfs_routing_online_free(node->routing);
		}
		if (node->mode == MODE_OFFLINE || node->mode == MODE_API_AVAILABLE) {
			ipfs_routing_offline_free(node->routing);
		}
		if (node->blockstore != NULL) {
			ipfs_blockstore_free(node->blockstore);
		}
		free(node);
	}
	return 1;
}
