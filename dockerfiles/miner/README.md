# TurtleCoin Miner Docker Image

This image pulls the binary from the base image and runs the miner on apline.

Build Arguments/Environment Variables:

| Name | Default | Function |
| --- | --- | --- |
| DAEMON_HOST | 127.0.0.1 | The daemon host to use for node operations |
| DAEMON_PORT | 11898 | The daemon RPC port to use for node operations |
| SCAN_TIME | 1 | Blockchain polling interval (seconds). How often miner will check the Blockchain for updates |
| ADDRESS | | The valid CryptoNote miner's address |
| BLOCK_TIMESTAMP_INTERVAL | 0 | Timestamp incremental step for each subsequent block. May be set only if --first-block-timestamp has been set. |
| FIRST_BLOCK_TIMESTAMP | 0 | Set timestamp to the first mined block. 0 means leave timestamp unchanged |
| LIMIT | 0 | Mine this exact quantity of blocks and then stop. 0 means no limit |
| THREADS | 8 | The mining threads count. Must not exceed hardware capabilities. |
| WEB_USERNAME |  | Username to access the web terminal |
| WEB_PASSWORD |  | Password to access the web terminal |

Examples:
```
docker build -t miner .
docker run -d -p 7681:7681 --name miner miner
```

To use miner navigate to http://localhost:7681 (or whatever port you pass in, e.g. ```-p 8080:7681```)

Passing in an address
```
docker build -t miner .
docker run -d -p 7681:7681 -e ADDRESS=TRTLuz2tDXUDHSAPzB1bZnQU9qyGnN5cX6htZZzjxPJ3Qr9u5hrQjsQBi7j7d75SAgDygkR1adQBhZHdQrFeWoaMXqWwytS37xT --name miner miner
```

Accessing the web terminal with a username and password:
```
docker run -d -p 7681:7681 -e WEB_USERNAME=Slow -e WEB_PASSWORD=AndSteady --name miner miner
```

This image is also hosted on [Docker Hub](https://cloud.docker.com/u/andrewnk/repository/docker/andrewnk/turtlecoin).

To run from the Docker Hub image:

```
docker run -d -p 7681:7681 --name miner andrewnk/turtlecoin:miner
```

To use from the Docker Hub image:

```
FROM andrewnk/turtlecoin:miner as miner
```
