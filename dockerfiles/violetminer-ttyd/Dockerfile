FROM alpine as git

ARG BRANCH=master
ENV BRANCH=${BRANCH}

WORKDIR /opt/violetminer

RUN apk add --no-cache --virtual git-dependency git && \
    git clone -b ${BRANCH} --single-branch https://github.com/turtlecoin/violetminer.git . && \
    git submodule update --init --recursive && \
    mkdir /opt/violetminer/build && \
    apk del git-dependency

FROM alpine as builder

COPY --from=git /opt/violetminer /opt/violetminer

WORKDIR /opt/violetminer/build

# add packages and build
RUN apk add --no-cache --virtual general-dependencies \
    cmake \
    build-base \
    openssl-dev && \
    cmake .. && \
    make && \
    mkdir /violetminer && \
    mv argon2-cpp-test violetminer /violetminer && \
    apk del general-dependencies

FROM alpine as base

# set turtlecoin shell to zsh in order to run tmux as a non root user
RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -s /bin/zsh -h /home/turtlecoin && \
    apk add --no-cache 'su-exec>=0.2'

COPY --from=builder /violetminer/ /usr/local/bin/

RUN apk add --no-cache \
    g++ \
    ttyd \
    tmux \
    zsh

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

CMD ["ttyd"]
