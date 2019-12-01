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
    cmake -DENABLE_NVIDIA=OFF .. && \
    make && \
    mkdir /violetminer && \
    mv argon2-cpp-test violetminer /violetminer && \
    apk del general-dependencies

FROM alpine as base

RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -h /home/turtlecoin && \
    apk add --no-cache 'su-exec>=0.2'

COPY --from=builder /violetminer/ /usr/local/bin/

RUN apk add --no-cache g++

VOLUME /home/turtlecoin
WORKDIR /home/turtlecoin

COPY ./docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["violetminer"]
