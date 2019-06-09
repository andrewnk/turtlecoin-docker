#!/bin/sh
set -e

# You can either supply your own source code or automatically download from the git repo
# The source code must be located in the turtlecoin dir. If the directory is empty then
# no source code was supplied and we will go ahead and change the config file and
# empty the checkpoints

rm -fr /opt/turtlecoin/.gitignore

if [[ ! "$(ls -A /opt/turtlecoin)" ]]; then
    echo -e "\033[1;32mCloning the repo..."
    git clone -b ${BRANCH} --single-branch ${REPO} .

    # we will look through all env variables, originally set in the dockerfile,
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
else
    echo -e "\033[1;32mUsing the supplied source code..."
fi

mkdir /opt/turtlecoin/build