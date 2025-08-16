#pragma once

#include <pthread.h>
#include "libp2p/peer/peerstore.h"
#include "libp2p/peer/providerstore.h"
#include "libp2p/swarm/swarm.h"
#include "ipfs/blocks/blockstore.h"
#include "ipfs/exchange/exchange.h"
#include "ipfs/repo/config/identity.h"
#include "ipfs/repo/fsrepo/fs_repo.h"
#include "ipfs/routing/routing.h"

/***
 * Holds information about the local node
 */

/***
 * Modes:
 * MODE_OFFLINE: Do everything yourself
 * MODE_API_AVAILABLE: If you want to, the API is running
 * MODE_ONLINE: You are the API
 */
enum NodeMode { MODE_OFFLINE, MODE_API_AVAILABLE, MODE_ONLINE };

struct IpfsNode {
	/***
	 * Modes:
	 * MODE_OFFLINE: Do everything yourself
	 * MODE_API_AVAILABLE: If you want to, the API is running
	 * MODE_ONLINE: You are the API
	 */
	enum NodeMode mode;
	struct Identity* identity;
	struct FSRepo* repo;
	struct Peerstore* peerstore;
	struct ProviderStore* providerstore;
	struct IpfsRouting* routing;
	struct Blockstore* blockstore;
	struct Exchange* exchange;
	struct Libp2pVector* protocol_handlers;
	struct ApiContext* api_context;
	struct Dialer* dialer;
	struct SwarmContext* swarm;
	//struct Pinner pinning; // an interface
	//struct Mount** mounts;
	// TODO: Add more here
};

/***
 * build an online IpfsNode
 * @param repo_path where the IPFS repository directory is
 * @param node the completed IpfsNode struct
 * @returns true(1) on success
 */
int ipfs_node_online_new(const char* repo_path, struct IpfsNode** node);

/***
 * build an offline IpfsNode
 * @param repo_path where the IPFS repository directory is
 * @param node the completed IpfsNode struct
 * @returns true(1) on success
 */
int ipfs_node_offline_new(const char* repo_path, struct IpfsNode** node);

/***
 * Free resources from the creation of an IpfsNode
 * @param node the node to free
 * @returns true(1)
 */
int ipfs_node_free(struct IpfsNode* node);
