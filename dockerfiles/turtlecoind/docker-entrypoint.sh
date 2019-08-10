#!/bin/sh
set -e

if [[ "$1" = 'TurtleCoind' ]]; then

    set -- "$@" --log-file ${LOG_FILE} \
            --log-level ${LOG_LEVEL} \
            --db-max-open-files ${DB_MAX_OPEN_FILES} \
            --db-read-buffer-size ${DB_READ_BUFFER_SIZE} \
            --db-threads ${DB_THREADS} \
            --db-write-buffer-size ${DB_WRITE_BUFFER_SIZE} \
            --allow-local-ip ${ALLOW_LOCAL_IP} \
            --hide-my-port ${HIDE_MY_PORT} \
            --p2p-bind-ip ${P2P_BIND_IP} \
            --p2p-bind-port ${P2P_BIND_PORT} \
            --p2p-external-port ${P2P_EXTERNAL_PORT} \
            --rpc-bind-ip ${RPC_BIND_IP} \
            --rpc-bind-port ${RPC_BIND_PORT} \
            --add-exclusive-node ${ADD_EXCLUSIVE_NODE} \
            --seed-node ${SEED_NODE} \
            --add-peer ${ADD_PEER} \
            --add-priority-node ${ADD_PRIORITY_NODE} \
            --enable-blockexplorer ${ENABLE_BLOCKEXPLORER} \
            --enable-cors ${ENABLE_CORS} \
            --fee-address ${FEE_ADDRESS} \
            --fee-amount ${FEE_AMOUNT} "$@"

    if [[ "$DB_ENABLE_COMPRESSION" = true ]]; then
        set -- "$@" --db-enable-compression
    fi

    if [[ "$LOAD_CHECKPOINTS" = true ]]; then
        # if checkpoints file doesn't exist then download
        if [[ ! -f ${CHECKPOINTS_LOCATION}${CHECKPOINTS_FILE} ]]; then
            wget https://raw.githubusercontent.com/turtlecoin/checkpoints/master/checkpoints.csv https://raw.githubusercontent.com/turtlecoin/checkpoints/master/checkpoints-1M.csv -P ${CHECKPOINTS_LOCATION} -O ${CHECKPOINTS_FILE}
        fi

        set -- "$@" --load-checkpoints ${CHECKPOINTS_LOCATION}${CHECKPOINTS_FILE}
    fi

    if [[ "$(id -u)" = '0' ]]; then
        find . \! -user turtlecoin -exec chown turtlecoin '{}' +
        exec su-exec turtlecoin "$@"
    fi
fi

exec "$@"
