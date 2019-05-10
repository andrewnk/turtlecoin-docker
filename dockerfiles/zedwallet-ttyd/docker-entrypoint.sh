#!/bin/sh
set -e

#for when the ttyd ssl bug is fixed
#ttyd --ssl --ssl-cert /ttyd/certs/server.crt --ssl-key /ttyd/certs/server.key --ssl-ca /ttyd/certs/ca.crt

# in order to maintain a single session and not restart to container on reload or crash
# we run the process with tmux
set -- ttyd

if [[ ! -z "$WEB_USERNAME" && ! -z "$WEB_PASSWORD" ]]; then
    set -- "$@" -c ${WEB_USERNAME}:${WEB_PASSWORD}
fi

set -- "$@" tmux new -A -s zedwallet \
    zedwallet \
    --remote-daemon ${REMOTE_DAEMON_HOST}:${REMOTE_DAEMON_PORT}

if [ "$1" = 'zedwallet' -a "$(id -u)" = '0' ]; then
    find . \! -user turtlecoin -exec chown turtlecoin '{}' +
    exec su-exec turtlecoin "$0" "$@"
fi

exec "$@"