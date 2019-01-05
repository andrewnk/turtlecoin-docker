FROM turtlecoin-base as base

FROM frolvlad/alpine-glibc

ARG REMOTE_DAEMON_HOST
ENV REMOTE_DAEMON_HOST=${REMOTE_DAEMON_HOST}

ARG REMOTE_DAEMON_PORT
ENV REMOTE_DAEMON_PORT=${REMOTE_DAEMON_PORT}

# add user
RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -h /home/turtlecoin && \
    mkdir -p /home/turtlecoin/.TurtleCoin /home/turtlecoin/bin

#copy binary from base
COPY --from=base /turtlecoin/zedwallet /home/turtlecoin/bin/zedwallet

WORKDIR /home/turtlecoin

# fix ownership
RUN chown -R turtlecoin:turtlecoin .

USER turtlecoin

ENTRYPOINT ["/bin/sh", "-c", "/home/turtlecoin/bin/zedwallet --remote-daemon $REMOTE_DAEMON_HOST:$REMOTE_DAEMON_PORT"]