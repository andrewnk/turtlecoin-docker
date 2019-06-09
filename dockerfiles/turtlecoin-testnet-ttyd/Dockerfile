FROM alpine as git

ARG BRANCH=development
ENV BRANCH=${BRANCH}

ARG REPO=https://github.com/turtlecoin/turtlecoin.git
ENV REPO=${REPO}

ARG CRYPTONOTE_NAME='TurtleCoinTestnet'
ENV CRYPTONOTE_NAME=${CRYPTONOTE_NAME}

ARG CRYPTONOTE_NETWORK='0x99, 0x9c, 0x9a, 0x6c, 0xcf, 0x52, 0x57, 0x41, 0x65, 0xf9, 0x91, 0xa4, 0xb6, 0xc1, 0x43, 0xe9'
ENV CRYPTONOTE_NETWORK=${CRYPTONOTE_NETWORK}

ARG SEED_NODES='"testnet-node1:11897", "testnet-node2:11897", "testnet-node3:11897"'
ENV SEED_NODES=${SEED_NODES}

WORKDIR /opt/turtlecoin

COPY prepare.sh /usr/local/bin/
COPY ./turtlecoin/ /opt/turtlecoin/

# Add necessary libraries and if using git then update config with env variables
RUN apk add --no-cache --virtual general-dependencies git perl && \
  chmod +x /usr/local/bin/prepare.sh && \
  prepare.sh && \
  rm -fr /usr/local/bin/prepare.sh && \
  apk del general-dependencies


FROM alpine as builder

ARG ENABLE_SSL=false
ENV ENABLE_SSL=${ENABLE_SSL}

COPY --from=git /opt/turtlecoin /opt/turtlecoin

WORKDIR /opt/turtlecoin/build

# add packages and build
RUN apk add --no-cache --virtual general-dependencies \
  git \
  cmake \
  binutils \
  expat-dev \
  build-base \
  boost-static \
  boost-dev \
  libucontext-dev \
  openssl-dev && \
  cmake -DCMAKE_C_FLAGS="-lucontext" -DENABLE_SSL=${ENABLE_SSL} .. && \
  make -j$(nproc) && \
  mkdir /turtlecoin && \
  find src -type f -perm /a+x -exec strip {} \; -exec mv {} /turtlecoin \; && \
  apk del general-dependencies


FROM alpine

# whether or not to delete the .TurtleCoinTestnet folder on creation
ARG DELETE_FOLDER=false
ENV DELETE_FOLDER=${DELETE_FOLDER}

# whether or not to delete the wallet file on creation
ARG DELETE_WALLET=true
ENV DELETE_WALLET=${DELETE_WALLET}

# these aren't secrets because they will only be used with a testnet
ARG SPEND_KEY=ad8978e4a59983335df6e0cef0015e397a124344a323dbd7b60ee05f1dedae01
ENV SPEND_KEY=${SPEND_KEY}

ARG VIEW_KEY=609f2e458fd8f2aa22f2a376128fc64705ce6a09ae0774c9b865311c55dd0c07
ENV VIEW_KEY=${VIEW_KEY}

ARG WALLET_NAME=testnetwallet
ENV WALLET_NAME=${WALLET_NAME}

ARG WALLET_PASSWORD=testnet
ENV WALLET_PASSWORD=${WALLET_PASSWORD}

# set turtlecoin shell to zsh in order to run tmux as a non root user
RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -s /bin/zsh -h /home/turtlecoin && \
    apk add --no-cache 'su-exec>=0.2'

COPY --from=builder /turtlecoin/ /usr/local/bin/

RUN apk add --no-cache libucontext-dev ttyd zsh tmux expect

VOLUME /home/turtlecoin
WORKDIR /home/turtlecoin

COPY docker-entrypoint.sh /usr/local/bin/
COPY expect-zedwallet.sh /usr/local/bin/
COPY zshrc /home/turtlecoin/.zshrc
COPY tmux.conf /home/turtlecoin/.tmux.conf

RUN chmod +x /usr/local/bin/docker-entrypoint.sh /usr/local/bin/expect-zedwallet.sh

EXPOSE 11897 11898

ENTRYPOINT ["docker-entrypoint.sh"]
