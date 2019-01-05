FROM turtlecoin-base as base

FROM frolvlad/alpine-glibc

ARG ADD_EXCLUSIVE_NODE=''
ENV ADD_EXCLUSIVE_NODE=${ADD_EXCLUSIVE_NODE}

ARG ADD_PEER=''
ENV ADD_PEER=${ADD_PEER}

ARG ADD_PRIORITY_NODE=''
ENV ADD_PRIORITY_NODE=${ADD_PRIORITY_NODE}

ARG ALLOW_LOCAL_IP=false
ENV ALLOW_LOCAL_IP=${ALLOW_LOCAL_IP}

ARG DB_MAX_OPEN_FILES=100
ENV DB_MAX_OPEN_FILES=${DB_MAX_OPEN_FILES}

ARG DB_READ_BUFFER_SIZE=10
ENV DB_READ_BUFFER_SIZE=${DB_READ_BUFFER_SIZE}

ARG DB_THREADS=2
ENV DB_THREADS=${DB_THREADS}

ARG DB_WRITE_BUFFER_SIZE=256
ENV DB_WRITE_BUFFER_SIZE=${DB_WRITE_BUFFER_SIZE}

ARG ENABLE_BLOCKEXPLORER=false
ENV ENABLE_BLOCKEXPLORER=${ENABLE_BLOCKEXPLORER}

ARG ENABLE_CORS=''
ENV ENABLE_CORS=${ENABLE_CORS}

ARG FEE_ADDRESS=''
ENV FEE_ADDRESS=${FEE_ADDRESS}

ARG FEE_AMOUNT=0
ENV FEE_AMOUNT=${FEE_AMOUNT}

ARG HIDE_MY_PORT=false
ENV HIDE_MY_PORT=${HIDE_MY_PORT}

ARG LOAD_CHECKPOINTS=''
ENV LOAD_CHECKPOINTS=${LOAD_CHECKPOINTS}

ARG LOG_FILE=TurtleCoind.log
ENV LOG_FILE=${LOG_FILE}

ARG LOG_LEVEL=WARNING
ENV LOG_LEVEL=${LOG_LEVEL}

ARG NO_CONSOLE=false
ENV NO_CONSOLE=${NO_CONSOLE}

ARG P2P_BIND_IP=0.0.0.0
ENV P2P_BIND_IP=${P2P_BIND_IP}

ARG P2P_BIND_PORT=11897
ENV P2P_BIND_PORT=${P2P_BIND_PORT}

ARG P2P_EXTERNAL_PORT=0
ENV P2P_EXTERNAL_PORT=${P2P_EXTERNAL_PORT}

ARG RPC_BIND_IP=127.0.0.1
ENV RPC_BIND_IP=${RPC_BIND_IP}

ARG RPC_BIND_PORT=11898
ENV RPC_BIND_PORT=${RPC_BIND_PORT}

# add user
RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -h /home/turtlecoin && \
    mkdir -p /home/turtlecoin/.TurtleCoin /home/turtlecoin/bin

#copy binary from builder
COPY --from=base /turtlecoin/TurtleCoind /home/turtlecoin/TurtleCoind

WORKDIR /home/turtlecoin

# fix ownership
RUN chown -R turtlecoin:turtlecoin .

USER turtlecoin

EXPOSE ${RPC_BIND_PORT} ${P2P_BIND_PORT}

ENTRYPOINT ["/bin/sh", "-c", "/home/turtlecoin/TurtleCoind", "--load-checkpoints", "${LOAD_CHECKPOINTS}", "--log-file", "${LOG_FILE}", "--log-level", "${LOG_LEVEL}", "--no-console", "${NO_CONSOLE}", "--db-max-open-files", "${DB_MAX_OPEN_FILES}", "--db-read-buffer-size", "${DB_READ_BUFFER_SIZE}", "--db-threads", "${DB_THREADS}", "--db-write-buffer-size", "${DB_WRITE_BUFFER_SIZE}", "--allow-local-ip", "${ALLOW_LOCAL_IP}", "--hide-my-port", "${HIDE_MY_PORT}", "--p2p-bind-ip", "${P2P_BIND_IP}", "--p2p-bind-port", "${P2P_BIND_PORT}", "--p2p-external-port", "${P2P_EXTERNAL_PORT}", "--rpc-bind-ip", "${RPC_BIND_IP}", "--rpc-bind-port", "${RPC_BIND_PORT}", "--add-exclusive-node", "${ADD_EXCLUSIVE_NODE}", "--add-peer", "${ADD_PEER}", "--add-priority-node", "${ADD_PRIORITY_NODE}", "--enable-blockexplorer", "${ENABLE_BLOCKEXPLORER}", "--enable-cors", "${ENABLE_CORS}", "--fee-address", "${FEE_ADDRESS}", "--fee-amount", "${FEE_AMOUNT}"]
