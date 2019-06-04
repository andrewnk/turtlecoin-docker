#!/bin/sh
set -e

# we will look through all env variables, originally set in the dockerfile
# and if there is a match we will replace the value in the file with the 
# env variable value
env | while IFS='=' read -r n v; do
    # check to see if the env variable is in our config file
    if grep -q ${n} src/config/CryptoNoteConfig.h; then
        # One regex to rule them all!
        # This is a search and replace regex. It finds three groups:
        # 1.) the env variable name followed by any possible combination leading up to our value
        # 2.) the value of the variable in the file
        # 3.) the closing characters
        # after splitting into groups we replace the string with the
        # first group + escaped env variable value + third group
        perl -i -0777 -0pe "s/(${n}\[?\]?\s*\=\s*[UINT64_C(]*[\"]?[\s*{\s*]*)(.*?)([\"]?[\s*}?\s*}]*?\s*?\s*;)/\1\Q\E$v\3/s" src/config/CryptoNoteConfig.h
    fi
done

# next we clear the checkpoints file
perl -i -0777 -0pe "s/(CHECKPOINTS\s*\=\s*{)(.*?)(\s*}\s*;)/\1\3/s" src/config/CryptoNoteCheckpoints.h
