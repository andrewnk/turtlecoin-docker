FROM turtlecoin-base as base

FROM frolvlad/alpine-glibc
ARG BINARY
ENV BINARY=${BINARY}

ARG P2P_BIND_PORT=11898
ENV P2P_BIND_PORT=${P2P_BIND_PORT}

ARG RPC_BIND_PORT=11897
ENV RPC_BIND_PORT=${RPC_BIND_PORT}

ENV ADD_EXCLUSIVE_NODE
ENV ADD_PEER
ENV ADD-PRIORITY_NODE
ENV ALLOW_LOCAL_IP
ENV DATA_DIR
ENV DB_MAX_OPEN_FILES
ENV DB_READ_BUFFER_SIZE
ENV DB_THREADS
ENV DB_WRITE_BUFFER_SIZE
ENV ENABLE_BLOCKEXPLORER
ENV ENABLE_CORS
ENV FEE_ADDRESS
ENV FEE_AMOUNT
ENV HIDE_MY_PORT
ENV LOAD_CHECKPOINTS
ENV LOG_FILE
ENV LOG_LEVEL
ENV NO_CONSOLE
ENV P2P_BIND_IP
ENV P2P_EXTERNAL_PORT
ENV RPC_BIND_IP
ENV SEED_NODE

# add user
RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -h /home/turtlecoin && \
    mkdir -p /home/turtlecoin/.TurtleCoin /home/turtlecoin/bin

#copy binary from builder
COPY --from=base /TurtleCoind /home/turtlecoin/bin/TurtleCoind

WORKDIR /home/turtlecoin

# fix ownership
RUN chown -R turtlecoin:turtlecoin .

USER turtlecoin

EXPOSE ${RPC_BIND_PORT} ${P2P_BIND_PORT}

ENTRYPOINT ["/bin/sh", "-c", "/home/turtlecoin/bin/TurtleCoind"]

CMD ["--data-dir", "${DATA_DIR}", "--load-checkpoints", "${LOAD_CHECKPOINTS}", "--log-file", "${LOG_FILE}", "--log-level", "${LOG_LEVEL}", "--no-console", "${NO_CONSOLE}", "--db-max-open-files", "${DB_MAX_OPEN_FILES}", "--db-read-buffer-size", "${DB_READ_BUFFER_SIZE}", "--db-threads", "${DB_THREADS}", "--db-write-buffer-size", "${DB_WRITE_BUFFER_SIZE}", "--allow-local-ip", "${ALLOW_LOCAL_IP}", "--hide-my-port", "${HIDE_MY_PORT}", "--p2p-bind-ip", "${P2P_BIND_IP}", "--p2p-bind-port", "${P2P_BIND_PORT}", "--p2p-external-port", "${P2P_EXTERNAL_PORT}", "--rpc-bind-ip", "${RPC_BIND_IP}", "--rpc-bind-port", "${RPC_BIND_PORT}", "--add-exclusive-node", "${ADD_EXCLUSIVE_NODE}", "--add-peer", "${ADD_PEER}", "--add-priority-node", "$ADD-{PRIORITY_NODE}", "--seed-node", "${SEED_NODE}", "--enable-blockexplorer", "${ENABLE_BLOCKEXPLORER}", "--enable-cors", "${ENABLE_CORS}", "--fee-address", "${FEE_ADDRESS}", "--fee-amount", "${FEE_AMOUNT}"]
