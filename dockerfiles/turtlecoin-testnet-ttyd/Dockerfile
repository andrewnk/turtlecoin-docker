FROM alpine as git

ARG BRANCH=development
ENV BRANCH=${BRANCH}

ARG ENABLE_SSL=false
ENV ENABLE_SSL=${ENABLE_SSL}

ARG CRYPTONOTE_NAME='TurtleCoinTestnet'
ENV CRYPTONOTE_NAME=${CRYPTONOTE_NAME}

ARG CRYPTONOTE_NETWORK='0x99, 0x9c, 0x9a, 0x6c, 0xcf, 0x52, 0x57, 0x41, 0x65, 0xf9, 0x91, 0xa4, 0xb6, 0xc1, 0x43, 0xe9'
ENV CRYPTONOTE_NETWORK=${CRYPTONOTE_NETWORK}

ARG SEED_NODES='"turtlecoind-node1:11897", "turtlecoind-node2:11897", "turtlecoind-node3:11897"'
ENV SEED_NODES=${SEED_NODES}

WORKDIR /opt/turtlecoin

# clone branch
RUN apk add --no-cache --virtual general-dependencies git perl && \
  git clone -b ${BRANCH} --single-branch https://github.com/turtlecoin/turtlecoin.git . && \
  mkdir /opt/turtlecoin/build

COPY update-configs.sh /opt/turtlecoin/

# update config with env variables
RUN chmod +x update-configs.sh && \
  ./update-configs.sh && \
  rm -fr update-configs.sh && \
  apk del general-dependencies


FROM alpine as builder

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

ARG DELETE_FOLDER=false
ENV DELETE_FOLDER=${DELETE_FOLDER}

# set turtlecoin shell to zsh in order to run tmux as a non root user
RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -s /bin/zsh -h /home/turtlecoin && \
    apk add --no-cache 'su-exec>=0.2'

COPY --from=builder /turtlecoin/ /usr/local/bin/

RUN apk add --no-cache libucontext-dev ttyd zsh tmux

VOLUME /home/turtlecoin
WORKDIR /home/turtlecoin

COPY docker-entrypoint.sh /usr/local/bin/
COPY zshrc /home/turtlecoin/.zshrc
COPY tmux.conf /home/turtlecoin/.tmux.conf

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 11897 11898

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["TurtleCoind"]