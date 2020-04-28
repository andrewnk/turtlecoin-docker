#!/bin/sh
set -e

#for when the ttyd ssl bug is fixed
#ttyd --ssl --ssl-cert /ttyd/certs/server.crt \
#   --ssl-key /ttyd/certs/server.key \
#   --ssl-ca /ttyd/certs/ca.crt

if [[ "$1" = 'ttyd' ]]; then
    if [[ ! -z "$WEB_USERNAME" && ! -z "$WEB_PASSWORD" ]]; then
        set -- "$@" -c ${WEB_USERNAME}:${WEB_PASSWORD}
    fi

    # in order to maintain a single session and not restart the
    # container on reload or crash we run the process with tmux
    set -- "$@" tmux new -A -s turtlecoin \
        wallet-api \
            --enable-cors ${ENABLE_CORS} \
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
