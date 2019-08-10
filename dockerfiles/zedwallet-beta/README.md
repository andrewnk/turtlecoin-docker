# TurtleCoin zedwallet-beta Docker Image

This image pulls the binary from the base image and runs zedwallet-beta on apline.

## Table of Contents
1. [Examples](#examples)
2. [Build Args/Env Variables](#build-arguments-and-environment-variables)

## Examples:
```
docker build -t zedwallet-beta .
docker run -it --name zedwallet-beta zedwallet-beta
```

Using a remote node
```
docker build -t zedwallet-beta .
docker run -it -e REMOTE_DAEMON_HOST=my-favorite-node.lol -e REMOTE_DAEMON_PORT=11898 -v turtlecoind:/home/turtlecoin/ --name zedwallet-beta zedwallet-beta
```

Running in detached mode using a remote node:
```
docker build -t zedwallet-beta .
docker run -d -e REMOTE_DAEMON_HOST=my-favorite-node.lol -e REMOTE_DAEMON_PORT=11898 -v turtlecoind:/home/turtlecoin/ --name zedwallet-beta zedwallet-beta
```

When running in detached mode, you may attach using:
```
docker attach zedwallet-beta
```

To detach, press CTRL+p+q

Running with a bind mount in detached mode:

```
docker build -t turtlecoind .
docker run -d --name zedwallet-beta -v ${PWD}/zedwallet-beta:/home/turtlecoin/ zedwallet-beta
```

This image is also hosted on [Docker Hub](https://hub.docker.com/r/andrewnk/turtlecoin).

To run from the Docker Hub image:

```
docker run -d --name zedwallet-beta andrewnk/turtlecoin:zedwallet-beta
```

To use from the Docker Hub image:

```
FROM andrewnk/turtlecoin:zedwallet-beta as zedwallet-beta
```

## Build Arguments and Environment Variables:

| Name | Function |
| --- | --- |
| REMOTE_DAEMON_HOST | If using a remote node, used to set the remote node host |
| REMOTE_DAEMON_PORT | If using a remote node, used to set the remote node port |
