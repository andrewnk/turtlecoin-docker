FROM andrewnk/turtlecoin:base as base

FROM alpine

# set turtlecoin shell to zsh in order to run tmux as a non root user
RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -s /bin/zsh -h /home/turtlecoin && \
    apk add --no-cache 'su-exec>=0.2'

# The daemon host to use for node operations (default: 127.0.0.1)
ARG DAEMON_HOST=127.0.0.1
ENV DAEMON_HOST=${DAEMON_HOST}

# The daemon RPC port to use for node operations (default: 11898)
ARG DAEMON_PORT=11898
ENV DAEMON_PORT=${DAEMON_PORT}

# Blockchain polling interval (seconds). How often miner will check the Blockchain for updates (default: 1)
ARG SCAN_TIME=1
ENV SCAN_TIME=${SCAN_TIME}

# The valid CryptoNote miner's address
ARG ADDRESS=
ENV ADDRESS=${ADDRESS}

# Timestamp incremental step for each subsequent block. May be set only if --first-block-timestamp has been set. (default: 0)
ARG BLOCK_TIMESTAMP_INTERVAL=0
ENV BLOCK_TIMESTAMP_INTERVAL=${BLOCK_TIMESTAMP_INTERVAL}

# Set timestamp to the first mined block. 0 means leave timestamp unchanged (default: 0)
ARG FIRST_BLOCK_TIMESTAMP=0
ENV FIRST_BLOCK_TIMESTAMP=${FIRST_BLOCK_TIMESTAMP}

# Mine this exact quantity of blocks and then stop. 0 means no limit (default: 0)
ARG LIMIT=0
ENV LIMIT=${LIMIT}

# The mining threads count. Must not exceed hardware capabilities. (default: 8)
ARG THREADS=8
ENV THREADS=${THREADS}

# Web username
ARG WEB_USERNAME
ENV WEB_USERNAME=${WEB_USERNAME}

# Web username
ARG WEB_PASSWORD
ENV WEB_PASSWORD=${WEB_PASSWORD}

# add library required to run binary, ttyd, tmux, and
# zsh (this is needed in order to run tmux from a non root user) and fix ownership
RUN apk add --no-cache libucontext-dev ttyd tmux zsh

#uncomment when the ttyd ssl bug is fixed
#RUN apk add --no-cache openssl && \
#    mkdir -p /ttyd/certs
#
#WORKDIR /ttyd/certs
#
# create a self signed ssl cert for secure ttyd
#RUN openssl genrsa -out ca.key 4096 && \
#    openssl req -new -x509 -days 365 -key ca.key -out ca.crt -subj "/C=TC/ST=TurtleCoin/L=TurtleCoin/O=TurtleCoin/OU=TurtleCoin/CN=localhost" && \
#    openssl req -newkey rsa:2048 -nodes -keyout server.key -out server.csr -subj "/C=TC/ST=TurtleCoin/L=TurtleCoin/O=TurtleCoin/OU=TurtleCoin/CN=localhost" && \
#    openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt && \
#    openssl req -newkey rsa:2048 -nodes -keyout client.key -out client.csr -subj "/C=TC/ST=TurtleCoin/L=TurtleCoin/O=TurtleCoin/OU=TurtleCoin/CN=localhost" && \
#    openssl x509 -req -days 365 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 02 -out client.crt && \
#    chown turtlecoin *

#copy binary from base
COPY --from=base /miner /usr/local/bin

WORKDIR /home/turtlecoin

COPY ./docker-entrypoint.sh /usr/local/bin/
COPY zshrc /home/turtlecoin/.zshrc

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ttyd"]
