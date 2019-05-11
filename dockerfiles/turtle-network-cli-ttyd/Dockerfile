FROM node:alpine

RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -h /home/turtlecoin && \
    apk add --no-cache 'su-exec>=0.2'

# Branch to clone
ARG BRANCH=master
ENV BRANCH=${BRANCH}

# Web username
ARG WEB_USERNAME
ENV WEB_USERNAME=${WEB_USERNAME}

# Web username
ARG WEB_PASSWORD
ENV WEB_PASSWORD=${WEB_PASSWORD}

WORKDIR /home/turtlecoin

# add binaries, clone, and delete git
RUN apk add --no-cache ttyd tmux && \
    apk add --no-cache --virtual .build-deps git python-dev build-base && \
    git clone --branch ${BRANCH} --single-branch https://github.com/turtlecoin/turtle-network-cli.git . && \
    npm run trtl && \
    npm audit fix && \
    apk del .build-deps

COPY ./docker-entrypoint.sh /usr/local/bin/

# fix ownership
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh && \
    ln -s /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
