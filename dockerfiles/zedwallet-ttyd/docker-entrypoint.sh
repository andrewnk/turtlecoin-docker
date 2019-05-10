#!/bin/sh
set -e

set -- zedwallet --remote-daemon ${REMOTE_DAEMON_HOST}:${REMOTE_DAEMON_PORT} "$@"

if [ "$1" = 'zedwallet' -a "$(id -u)" = '0' ]; then
    find . \! -user turtlecoin -exec chown turtlecoin '{}' +
    exec su-exec turtlecoin "$0" "$@"
fi

#uncomment when the ttyd ssl bug is fixed
#exec ttyd --ssl --ssl-cert /ttyd/certs/server.crt --ssl-key /ttyd/certs/server.key --ssl-ca /ttyd/certs/ca.crt "$@"

exec ttyd "$@"