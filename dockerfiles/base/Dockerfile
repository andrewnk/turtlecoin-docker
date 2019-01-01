FROM ubuntu:latest as builder

ARG BRANCH=master
ENV BRANCH=${BRANCH}

#create our clone dir
RUN mkdir -p /opt/turtlecoin

WORKDIR /opt/turtlecoin

#install git and clone
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        git \
        ca-certificates && \
    git clone -b ${BRANCH} --single-branch https://github.com/turtlecoin/turtlecoin.git . && \
    mkdir -p /opt/turtlecoin/build && \
    apt-get remove -y git ca-certificates && \
    apt-get autoremove -y && \
    apt-get clean

WORKDIR /opt/turtlecoin/build

# install build dependencies and build
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        build-essential \
        python-dev \
        cmake \
        git \
        libboost-all-dev && \
    cmake -DCMAKE_CXX_FLAGS="-g0 -Os -fPIC -std=gnu++11" .. && \
    make -j$(nproc) TurtleCoind zedwallet && \
    mv src/TurtleCoind src/zedwallet /opt && \
    strip /opt/TurtleCoind /opt/zedwallet && \
    apt-get remove -y build-essential python-dev cmake libboost-all-dev git && \
    apt-get autoremove -y && \
    apt-get clean

WORKDIR /opt

# remove cloned project
RUN rm -fr /opt/turtlecoin

FROM scratch

#copy binary from builder
COPY --from=builder /opt/* /