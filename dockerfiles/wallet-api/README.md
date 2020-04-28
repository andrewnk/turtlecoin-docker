# TurtleCoin Wallet API Docker Image

This image pulls the binary from the base image and runs wallet-api on apline.

## Table of Contents
1. [Examples](#examples)
2. [Build Args/Env Variables](#build-arguments-and-environment-variables)

## Examples:
```
docker build -t wallet-api .
docker run -it --name wallet-api wallet-api
```

## Build Arguments and Environment Variables:

| Name | Default |  Function |
| --- | --- | --- |
| ENABLE_CORS | | Adds header 'Access-Control-Allow-Origin' to the RPC responses. Uses the value specified as the domain. Use * for all. |
| LOG_LEVEL | 0 | # Specify log level |
| NO_CONSOLE | TRUE | If set, will not provide an interactive console |
| PORT | 8070 | The port to listen on for http requests |
| RPC_BIND_IP | 0.0.0.0 | Interface IP address for the RPC service |
| RPC_PASSWORD | password | Specify the <password> to access the RPC server |
| SCAN_COINBASE_TRANSACTIONS | FALSE | Scan miner/coinbase transactions |
| THREADS | 8 | Specify number of wallet sync threads |
