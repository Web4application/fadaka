#include <pthread.h>

#include "cid/test_cid.h"
#include "cmd/ipfs/test_init.h"
#include "core/test_api.h"
#include "core/test_ping.h"
#include "core/test_null.h"
#include "core/test_daemon.h"
#include "core/test_node.h"
#include "core/test_compat_go.h"
#include "exchange/test_bitswap.h"
#include "exchange/test_bitswap_request_queue.h"
#include "flatfs/test_flatfs.h"
#include "journal/test_journal.h"
#include "merkledag/test_merkledag.h"
#include "node/test_node.h"
#include "node/test_importer.h"
#include "node/test_resolver.h"
#include "repo/test_repo_bootstrap_peers.h"
#include "repo/test_repo_config.h"
#include "repo/test_repo_fsrepo.h"
#include "repo/test_repo_identity.h"
#include "routing/test_routing.h"
#include "routing/test_supernode.h"
#include "storage/test_ds_helper.h"
#include "storage/test_datastore.h"
#include "storage/test_blocks.h"
#include "storage/test_unixfs.h"
#include "libp2p/utils/logger.h"
#include "namesys/test_namesys.h"

struct test {
	int index;
	const char* name;
	int (*func)(void);
	int part_of_suite;
	struct test* next;
};

struct test* first_test = NULL;
struct test* last_test = NULL;

int testit(const char* name, int (*func)(void)) {
	fprintf(stderr, "TESTING %s...\n", name);
	int retVal = func();
	if (retVal)
		fprintf(stderr, "%s success!\n", name);
	else
		fprintf(stderr, "** Uh oh! %s failed.**\n", name);
	return retVal == 0;
}

int add_test(const char* name, int (*func)(void), int part_of_suite) {
	// create a new test
	struct test* t = (struct test*) malloc(sizeof(struct test));
	t->name = name;
	t->func = func;
	t->part_of_suite = part_of_suite;
	t->next = NULL;
	if (last_test == NULL)
		t->index = 0;
	else
		t->index = last_test->index + 1;
	// place it in the collection
	if (first_test == NULL) {
		first_test = t;
	} else {
		last_test->next = t;
	}
	last_test = t;
	if (last_test == NULL)
		return 0;
	return last_test->index;
}

int build_test_collection() {
	add_test("test_bitswap_new_free", test_bitswap_new_free, 1);
	add_test("test_bitswap_peer_request_queue_new", test_bitswap_peer_request_queue_new, 1);
	add_test("test_bitswap_retrieve_file", test_bitswap_retrieve_file, 1);
	add_test("test_bitswap_retrieve_file_known_remote", test_bitswap_retrieve_file_known_remote, 0);
	add_test("test_bitswap_retrieve_file_remote", test_bitswap_retrieve_file_remote, 1);
	add_test("test_bitswap_retrieve_file_third_party", test_bitswap_retrieve_file_third_party, 1);
	add_test("test_cid_new_free", test_cid_new_free, 1);
	add_test("test_cid_cast_multihash", test_cid_cast_multihash, 1);
	add_test("test_cid_cast_non_multihash", test_cid_cast_non_multihash, 1);
	add_test("test_cid_protobuf_encode_decode", test_cid_protobuf_encode_decode, 1);
	add_test("test_core_api_startup_shutdown", test_core_api_startup_shutdown, 1);
	add_test("test_core_api_object_cat", test_core_api_object_cat, 1);
	add_test("test_core_api_object_cat_binary", test_core_api_object_cat_binary, 1);
	add_test("test_core_api_object_cat_large_binary", test_core_api_object_cat_large_binary, 1);
	add_test("test_core_api_name_resolve", test_core_api_name_resolve, 1);
	add_test("test_core_api_name_resolve_1", test_core_api_name_resolve_1, 0);
	add_test("test_core_api_name_resolve_2", test_core_api_name_resolve_2, 0);
	add_test("test_core_api_name_resolve_3", test_core_api_name_resolve_3, 0);
	add_test("test_daemon_startup_shutdown", test_daemon_startup_shutdown, 1);
	add_test("test_datastore_list_journal", test_datastore_list_journal, 1);
	add_test("test_journal_db", test_journal_db, 1);
	add_test("test_journal_encode_decode", test_journal_encode_decode, 1);
	add_test("test_journal_server_1", test_journal_server_1, 0);
	add_test("test_journal_server_2", test_journal_server_2, 0);
	add_test("test_repo_config_new", test_repo_config_new, 1);
	add_test("test_repo_config_init", test_repo_config_init, 1);
	add_test("test_repo_config_write", test_repo_config_write, 1);
	add_test("test_repo_config_identity_new", test_repo_config_identity_new, 1);
	add_test("test_repo_config_identity_private_key", test_repo_config_identity_private_key, 1);
	add_test("test_repo_fsrepo_write_read_block", test_repo_fsrepo_write_read_block, 1);
	add_test("test_repo_fsrepo_build", test_repo_fsrepo_build, 1);
	add_test("test_routing_supernode_start", test_routing_supernode_start, 1);
	add_test("test_get_init_command", test_get_init_command, 1);
	add_test("test_import_small_file", test_import_small_file, 1);
	add_test("test_import_large_file", test_import_large_file, 1);
	add_test("test_repo_fsrepo_open_config", test_repo_fsrepo_open_config, 1);
	add_test("test_flatfs_get_directory", test_flatfs_get_directory, 1);
	add_test("test_flatfs_get_filename", test_flatfs_get_filename, 1);
	add_test("test_flatfs_get_full_filename", test_flatfs_get_full_filename, 1);
	add_test("test_ds_key_from_binary", test_ds_key_from_binary, 1);
	add_test("test_blocks_new", test_blocks_new, 1);
	add_test("test_repo_bootstrap_peers_init", test_repo_bootstrap_peers_init, 1);
	add_test("test_ipfs_datastore_put", test_ipfs_datastore_put, 1);
	add_test("test_node", test_node, 1);
	add_test("test_node_link_encode_decode", test_node_link_encode_decode, 1);
	add_test("test_node_encode_decode", test_node_encode_decode, 1);
	add_test("test_node_peerstore", test_node_peerstore, 1);
	add_test("test_merkledag_add_data", test_merkledag_add_data, 1);
	add_test("test_merkledag_get_data", test_merkledag_get_data, 1);
	add_test("test_merkledag_add_node", test_merkledag_add_node, 1);
	add_test("test_merkledag_add_node_with_links", test_merkledag_add_node_with_links, 1);
	add_test("test_namesys_publisher_publish", test_namesys_publisher_publish, 1);
	add_test("test_namesys_resolver_resolve", test_namesys_resolver_resolve, 1);
	add_test("test_resolver_get", test_resolver_get, 0); // not working (test directory does not exist)
	add_test("test_resolver_remote_get", test_resolver_remote_get, 0); // not working (test directory does not exist)
	add_test("test_routing_find_peer", test_routing_find_peer, 1);
	add_test("test_routing_provide", test_routing_provide, 1);
	add_test("test_routing_find_providers", test_routing_find_providers, 1);
	add_test("test_routing_put_value", test_routing_put_value, 1);
	add_test("test_routing_supernode_get_value", test_routing_supernode_get_value, 1);
	add_test("test_routing_supernode_get_remote_value", test_routing_supernode_get_remote_value, 1);
	add_test("test_routing_retrieve_file_third_party", test_routing_retrieve_file_third_party, 1);
	add_test("test_routing_retrieve_large_file", test_routing_retrieve_large_file, 1);
	add_test("test_unixfs_encode_decode", test_unixfs_encode_decode, 1);
	add_test("test_unixfs_encode_smallfile", test_unixfs_encode_smallfile, 1);
	add_test("test_ping", test_ping, 0); // socket connect failed
	add_test("test_ping_remote", test_ping_remote, 0); // need to test more
	add_test("test_null_add_provider", test_null_add_provider, 0); // need to test more
	add_test("test_compat_go_join_swarm", test_compat_go_join_swarm, 0); // remote must be running
	return 1;
}

/**
 * Pull the next test name from the command line
 * @param the count of arguments on the command line
 * @param argv the command line arguments
 * @param arg_number the current argument we want
 * @returns a null terminated string of the next test or NULL
 */
char* get_test(int argc, char** argv, int arg_number) {
	char* retVal = NULL;
	char* ptr = NULL;
	if (argc > arg_number) {
		ptr = argv[arg_number];
		if (ptr[0] == '\'')
			ptr++;
		retVal = ptr;
		ptr = strchr(retVal, '\'');
		if (ptr != NULL)
			ptr[0] = 0;
	}
	return retVal;
}

struct test* get_test_by_index(int index) {
	struct test* current = first_test;
	while (current != NULL && current->index != index) {
		current = current->next;
	}
	return current;
}

struct test* get_test_by_name(const char* name) {
	struct test* current = first_test;
	while (current != NULL && strcmp(current->name, name) != 0) {
		current = current->next;
	}
	return current;
}

/**
 * run certain tests or run all
 */
int main(int argc, char** argv) {
	int counter = 0;
	int tests_ran = 0;
	char* test_name_wanted = NULL;
	int certain_tests = 0;
	int current_test_arg = 1;
	if(argc > 1) {
		certain_tests = 1;
	}
	build_test_collection();
	if (certain_tests) {
		// certain tests were passed on the command line
		test_name_wanted = get_test(argc, argv, current_test_arg);
		while (test_name_wanted != NULL) {
			struct test* t = get_test_by_name(test_name_wanted);
			if (t != NULL) {
				tests_ran++;
				counter += testit(t->name, t->func);
			}
			test_name_wanted = get_test(argc, argv, ++current_test_arg);
		}
	} else {
		// run all tests that are part of this test suite
		struct test* current = first_test;
		while (current != NULL) {
			if (current->part_of_suite) {
				tests_ran++;
				counter += testit(current->name, current->func);
			}
			current = current->next;
		}
	}
	if (tests_ran == 0)
		fprintf(stderr, "***** No tests found *****\n");
	else {
		if (counter > 0) {
			fprintf(stderr, "***** There were %d failed (out of %d) test(s) *****\n", counter, tests_ran);
		} else {
			fprintf(stderr, "All %d tests passed\n", tests_ran);
		}
	}
	libp2p_logger_free();
	fclose(stdin);
	fclose(stdout);
	fclose(stderr);
	return 1;
}
