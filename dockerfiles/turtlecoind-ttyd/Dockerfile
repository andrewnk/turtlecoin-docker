FROM andrewnk/turtlecoin:base as base

FROM alpine

# set turtlecoin shell to zsh in order to run tmux as a non root user
RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -s /bin/zsh -h /home/turtlecoin && \
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

# Enable lz4 compression
ARG DB_ENABLE_COMPRESSION=true
ENV DB_ENABLE_COMPRESSION=${DB_ENABLE_COMPRESSION}

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

# Whether or not to load the daemon with checkpoints
ARG LOAD_CHECKPOINTS=true
ENV LOAD_CHECKPOINTS=${LOAD_CHECKPOINTS}

# The checkpoints file location
ARG CHECKPOINTS_LOCATION=/home/turtlecoin/
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

# Web username
ARG WEB_USERNAME
ENV WEB_USERNAME=${WEB_USERNAME}

# Web username
ARG WEB_PASSWORD
ENV WEB_PASSWORD=${WEB_PASSWORD}

# copy binary from builder
COPY --from=base /TurtleCoind /usr/local/bin

# add library required to run binary, ttyd, tmux, and 
# zsh (this is needed in order to run tmux from a non root user) and fix ownership
RUN apk add --no-cache libucontext-dev ttyd zsh tmux

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

VOLUME /home/turtlecoin
WORKDIR /home/turtlecoin

COPY ./docker-entrypoint.sh /usr/local/bin/
COPY zshrc /home/turtlecoin/.zshrc

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE ${RPC_BIND_PORT} ${P2P_BIND_PORT}

CMD ["ttyd"]
