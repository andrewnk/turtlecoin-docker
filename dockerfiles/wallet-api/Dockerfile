FROM andrewnk/turtlecoin:base as base

FROM alpine

RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -h /home/turtlecoin && \
    apk add --no-cache 'su-exec>=0.2'

# Adds header 'Access-Control-Allow-Origin' to the RPC responses. Uses the value specified as the domain. Use * for all.
ARG ENABLE_CORS=''
ENV ENABLE_CORS=${ENABLE_CORS}

# Specify log level
ARG LOG_LEVEL=0
ENV LOG_LEVEL=${LOG_LEVEL}

# If set, will not provide an interactive console
ARG NO_CONSOLE=TRUE
ENV NO_CONSOLE=${NO_CONSOLE}

# The port to listen on for http requests
ARG PORT=8070
ENV PORT=${PORT}

# Interface IP address for the RPC service
ARG RPC_BIND_IP=0.0.0.0
ENV RPC_BIND_IP=${RPC_BIND_IP}

# Specify the <password> to access the RPC server
ARG RPC_PASSWORD=password
ENV RPC_PASSWORD=${RPC_PASSWORD}

# Scan miner/coinbase transactions
ARG SCAN_COINBASE_TRANSACTIONS=FALSE
ENV SCAN_COINBASE_TRANSACTIONS=${SCAN_COINBASE_TRANSACTIONS}

# Specify number of wallet sync threads
ARG THREADS=8
ENV THREADS=${THREADS}

# add library required to run binary
RUN apk add --no-cache libucontext-dev

#copy binary from base
COPY --from=base /wallet-api /usr/local/bin

VOLUME /home/turtlecoin
WORKDIR /home/turtlecoin

COPY ./docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE ${PORT}

CMD ["wallet-api"]
