#!/bin/sh
set -e

set -- miner \
        --daemon-address ${DAEMON_HOST}:${DAEMON_PORT} \
        --scan-time ${SCAN_TIME} \
        --address ${ADDRESS} \
        --block-timestamp-interval ${BLOCK_TIMESTAMP_INTERVAL} \
        --first-block-timestamp ${FIRST_BLOCK_TIMESTAMP} \
        --limit ${LIMIT} \
        --threads ${THREADS} "$@"

if [ "$1" = 'miner' -a "$(id -u)" = '0' ]; then
    find . \! -user turtlecoin -exec chown turtlecoin '{}' +
    exec su-exec turtlecoin "$0" "$@"
fi

exec "$@"
