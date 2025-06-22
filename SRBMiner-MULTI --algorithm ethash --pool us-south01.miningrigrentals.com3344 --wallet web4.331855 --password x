#!/usr/bin/env bash

	local MINER_VER=$CUSTOM_VER
	[[ -z $MINER_VER ]] && MINER_VER=$MINER_LATEST_VER
	echo $MINER_VER

	local MINER_VER=`miner_ver`

	MINER_CONFIG="$MINER_DIR/$MINER_NAME/lolminer.conf"
	GLOBAL_CONFIG="$MINER_DIR/$MINER_NAME/global_config.conf"
	mkfile_from_symlink $MINER_CONFIG

	#ALGO
	case  $CUSTOM_ALGO in

	 "ethash")
		 conf="--algo ETHASH\n"
	;;
	"etchash")
                 conf="--algo ETCHASH\n"
        ;;
	"autolykos2" |  "autolykos" )
                 conf="--algo AUTOLYKOS2\n"
        ;;
	"beamhashv3")
                 conf="--algo BEAM-III\n"
        ;;
	"ubqhash")
                 conf="--algo UBQAHSH\n"
        ;;
	*)
		conf="--algo TON\n"
	;;
	esac

	#POOL

        local host_cnt=$(echo $CUSTOM_URL | wc -w)
        LOLMINER_SERVER=($CUSTOM_URL)
        for ((i=0; i<$host_cnt; i++)); do
                #URL
                local url="${LOLMINER_SERVER[$i]}"
                conf+="--pool $url\n"
                # WALLET
                conf+="--user $CUSTOM_TEMPLATE\n"
                # PASSWORD
                if [[ ! -z $CUSTOM_PASS ]]; then
                        conf+="--pass $CUSTOM_PASS\n"
                fi
        done

	# TLS and other options
	[[ $CUSTOM_TLS -eq 1 ]] && conf+="--tls 1\n"

	while read -r line; do
                [[ -z $line ]] && continue
                local tls_cnt=$(echo "$line" | grep -e "--tls" | awk '{print $2}' | tr ';' ' ' | wc -w)
                if [[ $tls_cnt -eq 1 ]]; then
                        local tls_val=$(echo "$line" | grep -e "--tls" | awk '{print $2}')
                        for ((i=0; i<$host_cnt; i++)); do
                                conf+="--tls $tls_val\n"
                        done
                else
                        conf+="$line\n"
                fi
        done <<< "$CUSTOM_USER_CONFIG"

        conf+="--apiport $CUSTOM_API_PORT\n"

	conf+=`cat $GLOBAL_CONFIG`"\n"

	echo -e "$conf" > $MINER_CONFIG

