#!/bin/sh
set -e

if [[ "$1" = 'pm2-runtime' ]]; then

    set -- "$@" start ../turtlecoind-ha/turtlecoind-ha.js --name turtlecoind

    if [[ ! -f ${CHECKPOINTS_LOCATION}${CHECKPOINTS_FILE} ]]; then
        wget https://raw.githubusercontent.com/turtlecoin/checkpoints/master/checkpoints.csv https://raw.githubusercontent.com/turtlecoin/checkpoints/master/checkpoints-1M.csv -P ${CHECKPOINTS_LOCATION} -O ${CHECKPOINTS_FILE}
    fi

    if [[ "$(id -u)" = '0' ]]; then
        find . \! -user turtlecoin -exec chown turtlecoin '{}' +
        export PATH="$PATH:/home/turtlecoin/npm/bin"
        export NODE_PATH="$NODE_PATH:/home/turtlecoin/npm/lib/node_modules"
        exec su-exec turtlecoin "$@"
    fi
fi

exec "$@"
