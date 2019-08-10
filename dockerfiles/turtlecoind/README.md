# TurtleCoin TurtleCoind Docker Image

This image pulls the binary from the base image and runs TurtleCoind on apline.

## Table of Contents
1. [Examples](#examples)
2. [Build Args/Env Variables](#build-arguments-and-environment-variables)

## Examples:
```
docker build -t turtlecoind .
docker run -it -p 11898:11898 -p 11897:11897 --name turtlecoind -v turtlecoind:/home/turtlecoin/ turtlecoind
```

or:

```
docker build -t turtlecoind .
docker run -d -p 11898:11898 -p 11897:11897 --name turtlecoind -v turtlecoind:/home/turtlecoin/ turtlecoind
```

With a bind mount:

```
docker build -t turtlecoind .
docker run -d --name turtlecoind -v ${PWD}:/home/turtlecoin/ turtlecoind
```

When running in detached mode, you may attach using:
```
docker attach turtlecoind
```

To detach, press CTRL+p+q

This image is also hosted on [Docker Hub](https://hub.docker.com/r/andrewnk/turtlecoin). 

To run from the Docker Hub image:

```
docker run -d -p 11898:11898 -p 11897:11897 --name turtlecoind -v turtlecoind:/home/turtlecoin/ andrewnk/turtlecoin:turtlecoind
```

To use from the Docker Hub image:

```
FROM andrewnk/turtlecoin:turtlecoind as turtlecoind
```

## Build Arguments and Environment Variables:

| Name | Default | Function |
| --- | --- | --- |
| ADD_EXCLUSIVE_NODE | | Manually add a peer to the local peer list ONLY attempt connections to it. [ip:port] |
| ADD_PEER | | Manually add a peer to the local peer list [ip:port] |
| SEED_NODE | | Connect to a node to retrieve the peer list and then disconnect [ip:port] |
| ADD_PRIORITY_NODE | | Manually add a peer to the local peer list and attempt to maintain a connection to it [ip:port] |
| ALLOW_LOCAL_IP | false | Allow the local IP to be added to the peer list |
| DB_MAX_OPEN_FILES | 100 | Number of files that can be used by the database at one time |
| DB_READ_BUFFER_SIZE | 10 | Size of the database read cache in megabytes (MB) |
| DB_THREADS | 2 | Number of background threads used for compaction and flush operations |
| DB_WRITE_BUFFER_SIZE | 256 | Size of the database write buffer in megabytes (MB) |
| ENABLE_BLOCKEXPLORER | false | Enable the Blockchain Explorer RPC |
| DB_ENABLE_COMPRESSION | true | Enable lz4 compression |
| ENABLE_CORS | | Adds header 'Access-Control-Allow-Origin' to the RPC responses using the <domain>. Uses the value specified as the domain. Use * for all. |
| FEE_ADDRESS | | Sets the convenience charge <address> for light wallets that use the daemon |
| FEE_AMOUNT | 0 | Sets the convenience charge amount for light wallets that use the daemon |
| HIDE_MY_PORT | false | Do not announce yourself as a peerlist candidate |
| LOAD_CHECKPOINTS | true | Whether or not to load the daemon with checkpoints |
| CHECKPOINTS_LOCATION | /home/turtlecoin/ | The checkpoints file location |
| CHECKPOINTS_FILE | checkpoints.csv | The checkpoints file name |
| LOG_FILE | /home/turtlecoin/TurtleCoind.log | Specify the <path> to the log file |
| LOG_LEVEL | 2 | Specify log level |
| P2P_BIND_IP | 0.0.0.0 | Interface IP address for the P2P service |
| P2P_BIND_PORT | 11897 | TCP port for the P2P service |
| P2P_EXTERNAL_PORT | 0 | External TCP port for the P2P service (NAT port forward) |
| RPC_BIND_IP | 127.0.0.1 | Interface IP address for the RPC service |
| RPC_BIND_PORT | 11898 | TCP port for the RPC service |
