FROM node:alpine

RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin && \
    apk add --no-cache 'su-exec>=0.2'

# Web username
ARG WEB_USERNAME
ENV WEB_USERNAME=${WEB_USERNAME}

# Web username
ARG WEB_PASSWORD
ENV WEB_PASSWORD=${WEB_PASSWORD}

# add ttyd and tmux
RUN apk add --no-cache ttyd tmux && \
    npm i -g turtlecoin-test-suite

COPY ./docker-entrypoint.sh /usr/local/bin/

# fix ownership
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh && \
    ln -s /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
