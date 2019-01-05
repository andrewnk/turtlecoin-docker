FROM alpine as git

ARG BRANCH=development
ENV BRANCH=${BRANCH}

WORKDIR /opt/turtlecoin

RUN apk add --no-cache --virtual git-dependency git && \
    git clone -b ${BRANCH} --single-branch https://github.com/turtlecoin/turtlecoin.git . && \
    mkdir /opt/turtlecoin/build && \
    apk del git-dependency

FROM alpine as builder

COPY --from=git /opt/turtlecoin /opt/turtlecoin

WORKDIR /opt/turtlecoin/build

# add packages and build
RUN apk add --no-cache --virtual general-dependencies \
    git \
    cmake \
    binutils \
    expat-dev && \
    apk add --no-cache --virtual build-base-dependency build-base --repository http://dl-cdn.alpinelinux.org/alpine/edge/main && \
    apk add --no-cache --virtual boost-dependency boost-build --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
    apk add --no-cache libucontext-dev && \
    cmake -DCMAKE_C_FLAGS="-lucontext" .. && \
    make -j$(nproc) && \
    mkdir /turtlecoin && \
    find src -type f -perm /a+x -exec strip {} \; -exec mv {} /turtlecoin \; && \
    apk del general-dependencies build-base-dependency boost-dependency

FROM scratch as base

COPY --from=builder /turtlecoin/ /
