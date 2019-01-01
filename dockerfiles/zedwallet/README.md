# TurtleCoin zedwallet Docker Image

This image pulls the binary from the base image and runs zedwallet within apline.

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


using a remote node
```
docker build --build-arg REMOTE_DAEMON_HOST=my-favorite-node.lol  --build-arg REMOTE_DAEMON_PORT=11898 -t zedwallet .
docker run -it zedwallet
```

or

```
docker build -t zedwallet .
docker run -it -e REMOTE_DAEMON_HOST=my-favorite-node.lol -e REMOTE_DAEMON_PORT=11898 zedwallet
```