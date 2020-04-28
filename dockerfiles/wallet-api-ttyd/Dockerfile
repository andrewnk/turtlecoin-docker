FROM andrewnk/turtlecoin:base as base

FROM alpine

# set turtlecoin shell to zsh in order to run tmux as a non root user
RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -s /bin/zsh -h /home/turtlecoin && \
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
COPY --from=base /wallet-api /usr/local/bin

VOLUME /home/turtlecoin
WORKDIR /home/turtlecoin

COPY ./docker-entrypoint.sh /usr/local/bin/
COPY zshrc /home/turtlecoin/.zshrc

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ttyd"]
