#!/bin/sh
set -e

if [[ "$DELETE_FOLDER" ]]; then
    rm -rf ..?* .[!.]* *
fi

if [[ "$DELETE_WALLET" ]]; then
    rm -f *.wallet
fi

find . \! -user turtlecoin -exec chown turtlecoin '{}' +

exec "$@"