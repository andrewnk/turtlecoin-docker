#!/bin/sh
set -e

if [[ "$1" = 'wallet-api' ]]; then

    set -- "$@" --enable-cors ${ENABLE_CORS} \
                --log-level ${LOG_LEVEL} \
                --no-console ${NO_CONSOLE} \
                --port ${PORT} \
                --rpc-bind-ip ${RPC_BIND_IP} \
                --rpc-password ${RPC_PASSWORD} \
                --scan-coinbase-transactions ${SCAN_COINBASE_TRANSACTIONS} \
                --threads ${THREADS} "$@"

    if [[ "$(id -u)" = '0' ]]; then
        find . \! -user turtlecoin -exec chown turtlecoin '{}' +
        exec su-exec turtlecoin "$@"
    fi
fi

exec "$@"
