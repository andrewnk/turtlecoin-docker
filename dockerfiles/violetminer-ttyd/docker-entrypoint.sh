#!/bin/sh
set -e

#for when the ttyd ssl bug is fixed
#ttyd --ssl --ssl-cert /ttyd/certs/server.crt \
#   --ssl-key /ttyd/certs/server.key \
#   --ssl-ca /ttyd/certs/ca.crt

if [[ "$1" = 'ttyd' ]]; then

    set -- "$@" tmux new -A -s turtlecoin \
        violetminer

    if [[ "$(id -u)" = '0' ]]; then
        find . \! -user turtlecoin -exec chown turtlecoin '{}' +
        exec su-exec turtlecoin "$@"
    fi
fi

exec "$@"
