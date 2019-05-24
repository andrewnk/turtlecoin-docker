#!/bin/sh
set -e

if [[ "$1" = 'ttyd' ]]; then

    if [[ ! -z "$WEB_USERNAME" && ! -z "$WEB_PASSWORD" ]]; then
        set -- "$@" -c ${WEB_USERNAME}:${WEB_PASSWORD}
    fi

    set -- "$@" tmux new -A -s turtlecoin \
                    pm2-runtime start ../turtlecoind-ha/turtlecoind-ha.js --name turtlecoind

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
