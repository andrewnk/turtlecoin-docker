# TurtleCoin Wallet NodeJs With TTYD Docker Image

This is a dockerization of the [TurtleCoin Wallet NodeJs](https://github.com/turtlecoin/turtlecoin-wallet-nodejs) running on apline with ttyd. The process is run within tmux to persist the session in case the page reloads or crashes.

## Table of Contents
1. [Examples](#examples)
2. [Build Args/Env Variables](#build-arguments-and-environment-variables)

## Examples:
```
docker build -t turtlecoin-wallet-nodejs-ttyd .
docker run -d -p 7681:7681 --name turtlecoin-wallet-nodejs-ttyd -v divine:/home/turtlecoin turtlecoin-wallet-nodejs-ttyd
```

To use the test suite navigate to http://localhost:7681 (or whatever port you pass in, e.g. ```-p 8080:7681```)

Running with a bind mount:

```
docker build -t zedwallet-ttyd .
docker run -d -p 7681:7681 --name turtlecoin-wallet-nodejs-ttyd -v ${PWD}/divine:/home/turtlecoin turtlecoin-wallet-nodejs-ttyd
```

Accessing the web terminal with a username and password:
```
docker run -d -p 7681:7681 -e WEB_USERNAME=Slow -e WEB_PASSWORD=AndSteady --name turtlecoin-wallet-nodejs-ttyd -v divine:/home/turtlecoin turtlecoin-wallet-nodejs-ttyd
```

This image is also hosted on [Docker Hub](https://hub.docker.com/r/andrewnk/turtlecoin). 

To run from the Docker Hub image:

```
docker run -d -p 7681:7681 --name turtlecoin-wallet-nodejs-ttyd -v divine:/home/turtlecoin andrewnk/turtlecoin:turtlecoin-wallet-nodejs-ttyd
```

To use from the Docker Hub image:

```
FROM andrewnk/turtlecoin:turtlecoin-wallet-nodejs-ttyd as turtlecoin-wallet-nodejs-ttyd
```

## Build Arguments and Environment Variables:

| Name | Default | Function |
| --- | --- | --- |
| WEB_USERNAME |  | Username to access the web terminal |
| WEB_PASSWORD |  | Password to access the web terminal |
