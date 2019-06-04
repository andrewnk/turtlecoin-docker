#!/bin/sh
set -e

if [[ "$DELETE_FOLDER" ]]; then
    rm -rf ..?* .[!.]* *
fi

find . \! -user turtlecoin -exec chown turtlecoin '{}' +

exec "$@"