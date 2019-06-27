FROM andrewnk/turtlecoin:base as base

FROM alpine

RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -h /home/turtlecoin && \
    apk add --no-cache 'su-exec>=0.2'

# Manually add a peer to the local peer list ONLY attempt connections to it. [ip:port]
ARG ADD_EXCLUSIVE_NODE=''
ENV ADD_EXCLUSIVE_NODE=${ADD_EXCLUSIVE_NODE}

# Manually add a peer to the local peer list [ip:port]
ARG ADD_PEER=''
ENV ADD_PEER=${ADD_PEER}

# Connect to a node to retrieve the peer list and then disconnect [ip:port]
ARG SEED_NODE=''
ENV SEED_NODE=${SEED_NODE}

# Manually add a peer to the local peer list and attempt to maintain a connection to it [ip:port]
ARG ADD_PRIORITY_NODE=''
ENV ADD_PRIORITY_NODE=${ADD_PRIORITY_NODE}

# Allow the local IP to be added to the peer list
ARG ALLOW_LOCAL_IP=false
ENV ALLOW_LOCAL_IP=${ALLOW_LOCAL_IP}

# Number of files that can be used by the database at one time
ARG DB_MAX_OPEN_FILES=100
ENV DB_MAX_OPEN_FILES=${DB_MAX_OPEN_FILES}

# Size of the database read cache in megabytes (MB)
ARG DB_READ_BUFFER_SIZE=10
ENV DB_READ_BUFFER_SIZE=${DB_READ_BUFFER_SIZE}

# Number of background threads used for compaction and flush operations
ARG DB_THREADS=2
ENV DB_THREADS=${DB_THREADS}

# Size of the database write buffer in megabytes (MB)
ARG DB_WRITE_BUFFER_SIZE=256
ENV DB_WRITE_BUFFER_SIZE=${DB_WRITE_BUFFER_SIZE}

# Enable the Blockchain Explorer RPC
ARG ENABLE_BLOCKEXPLORER=false
ENV ENABLE_BLOCKEXPLORER=${ENABLE_BLOCKEXPLORER}

# Adds header 'Access-Control-Allow-Origin' to the RPC responses using the <domain>. Uses the value specified as the domain. Use * for all.
ARG ENABLE_CORS=''
ENV ENABLE_CORS=${ENABLE_CORS}

# Sets the convenience charge <address> for light wallets that use the daemon
ARG FEE_ADDRESS=''
ENV FEE_ADDRESS=${FEE_ADDRESS}

# Sets the convenience charge amount for light wallets that use the daemon
ARG FEE_AMOUNT=0
ENV FEE_AMOUNT=${FEE_AMOUNT}

# Do not announce yourself as a peerlist candidate
ARG HIDE_MY_PORT=false
ENV HIDE_MY_PORT=${HIDE_MY_PORT}

# The checkpoints file location
ARG CHECKPOINTS_LOCATION=/home/turtlecoin/turtlecoind/
ENV CHECKPOINTS_LOCATION=${CHECKPOINTS_LOCATION}

# The checkpoints file name
ARG CHECKPOINTS_FILE=checkpoints.csv
ENV CHECKPOINTS_FILE=${CHECKPOINTS_FILE}

# Specify the <path> to the log file
ARG LOG_FILE=/home/turtlecoin/logs/TurtleCoind.log
ENV LOG_FILE=${LOG_FILE}

# Specify log level
ARG LOG_LEVEL=2
ENV LOG_LEVEL=${LOG_LEVEL}

# Interface IP address for the P2P service
ARG P2P_BIND_IP=0.0.0.0
ENV P2P_BIND_IP=${P2P_BIND_IP}

# TCP port for the P2P service
ARG P2P_BIND_PORT=11897
ENV P2P_BIND_PORT=${P2P_BIND_PORT}

# External TCP port for the P2P service (NAT port forward)
ARG P2P_EXTERNAL_PORT=0
ENV P2P_EXTERNAL_PORT=${P2P_EXTERNAL_PORT}

# Interface IP address for the RPC service
ARG RPC_BIND_IP=127.0.0.1
ENV RPC_BIND_IP=${RPC_BIND_IP}

# TCP port for the RPC service
ARG RPC_BIND_PORT=11898
ENV RPC_BIND_PORT=${RPC_BIND_PORT}

# copy binary from builder
COPY --from=base /TurtleCoind /usr/local/bin
COPY ./docker-entrypoint.sh /usr/local/bin/

WORKDIR /home/turtlecoin/turtlecoind-ha
COPY ./turtlecoind-ha.js ./log.js /home/turtlecoin/turtlecoind-ha/

# add library required to run binary and fix ownership
RUN apk add --no-cache libucontext-dev nodejs npm && \
    apk add --no-cache --virtual .build-deps alpine-sdk python git && \
    git init && \
    git remote add origin https://github.com/turtlecoin/turtlecoind-ha.git && \
    git pull origin master && \
    mkdir -p /home/turtlecoin/npm && \
    npm config set prefix /home/turtlecoin/npm && \
    export PATH="$PATH:/home/turtlecoin/npm/bin" && \
    export NODE_PATH="$NODE_PATH:/home/turtlecoin/npm/lib/node_modules" && \
    npm install -g pm2 && \
    npm install @pm2/io --save && \
    pm2 install pm2-logrotate && \
    npm install winston && \
    apk del .build-deps && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /home/turtlecoin/turtlecoind
VOLUME /home/turtlecoin/turtlecoind

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE ${RPC_BIND_PORT} ${P2P_BIND_PORT}

CMD ["pm2-runtime"]