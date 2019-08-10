#!/bin/sh
set -e

if [[ "$1" = 'violetminer' ]]; then

    if [[ "$(id -u)" = '0' ]]; then
        find . \! -user turtlecoin -exec chown turtlecoin '{}' +
        exec su-exec turtlecoin "$@"
    fi
fi

exec "$@"
