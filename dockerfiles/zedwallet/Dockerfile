FROM andrewnk/turtlecoin:base as base

FROM alpine

ARG REMOTE_DAEMON_HOST
ENV REMOTE_DAEMON_HOST=${REMOTE_DAEMON_HOST}

ARG REMOTE_DAEMON_PORT
ENV REMOTE_DAEMON_PORT=${REMOTE_DAEMON_PORT}

# add library required to run binary and add user
RUN apk add --no-cache libucontext-dev && \
    addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -h /home/turtlecoin && \
    mkdir -p /home/turtlecoin/.TurtleCoin /home/turtlecoin/bin

#copy binary from base
COPY --from=base /zedwallet /home/turtlecoin/bin/zedwallet

WORKDIR /home/turtlecoin

# fix ownership
RUN chown -R turtlecoin:turtlecoin .

USER turtlecoin

VOLUME ["/home/turtlecoin/.TurtleCoin"]

ENTRYPOINT ["/bin/sh", "-c", "/home/turtlecoin/bin/zedwallet --remote-daemon ${REMOTE_DAEMON_HOST}:${REMOTE_DAEMON_PORT}"]
