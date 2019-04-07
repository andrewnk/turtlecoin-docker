# TurtleCoin zedwallet Docker Image

This image pulls the binary from the base image and runs zedwallet on apline.

Build Arguments/Environment Variables:

| Name | Function |
| --- | --- |
| REMOTE_DAEMON_HOST | If using a remote node, used to set the remote node host |
| REMOTE_DAEMON_PORT | If using a remote node, used to set the remote node port |

Examples:
```
docker build -t zedwallet .
docker run -it zedwallet
```

Using a remote node
```
docker build -t zedwallet .
docker run -it -e REMOTE_DAEMON_HOST=my-favorite-node.lol -e REMOTE_DAEMON_PORT=11898 -v turtlecoind:/home/turtlecoin/ --name zedwallet zedwallet
```

Running in detached mode using a remote node:
```
docker build -t zedwallet .
docker run -d -e REMOTE_DAEMON_HOST=my-favorite-node.lol -e REMOTE_DAEMON_PORT=11898 -v turtlecoind:/home/turtlecoin/ --name zedwallet zedwallet
```

When running in detached mode, you may attach using:
```
docker attach zedwallet
```

To detach, press CTRL+p+q

This image is also hosted on [Docker Hub](https://cloud.docker.com/u/andrewnk/repository/docker/andrewnk/turtlecoin). To use from the Docker Hub image:

```
FROM andrewnk/turtlecoin:zedwallet as zedwallet
```
