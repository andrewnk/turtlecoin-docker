# TurtleCoin Docker

This repo is a collection of Docker images and Docker Compose files that run a variety of TurtleCoin software. The only thing you need to get up is running is [Docker](https://docs.docker.com/install/#supported-platforms) and [Docker Compose](https://docs.docker.com/compose/install/) (if you want to run the Docker Compose files).

All images use Alpine as the base which reduces a lot of bloat, keeping the final images very small and portable.

Current list of Docker images (more to come soon):

| Name | Description |
| --- | --- |
| [Base](dockerfiles/base) | Contains all TurtleCoin binaries and is meant to be a starting point to build from |
| [Miner](dockerfiles/miner) | Image that runs the TurtleCoin Miner|
| [Miner with TTYD](dockerfiles/miner-ttyd) | Image that runs the TurtleCoin Miner with TTYD |
| [Turtle CLI py With TTYD](dockerfiles/turtle-cli-py-ttyd) | Image that runs Turtle CLI py With TTYD |
| [TurtleCoind](dockerfiles/turtlecoind) | Image that runs TurtleCoind |
| [TurtleCoind with TTYD](dockerfiles/turtlecoind-ttyd) | Image that runs TurtleCoind with TTYD |
| [TurtleCoin Test Suite with TTYD](dockerfiles/turtlecoin-test-suite-ttyd) | Image that runs TurtleCoin Test Suite with TTYD |
| [Turtle Network CLI With TTYD ](dockerfiles/turtle-network-cli-ttyd) | Image that runs Turtle Network CLI with TTYD |
| [TurtleCoin Wallet NodeJS With TTYD ](dockerfiles/turtlecoin-wallet-nodejs-ttyd) | Image that runs TurtleCoin Wallet NodeJS with TTYD |
| [zedwallet](dockerfiles/zedwallet) | Image that runs zedwallet |
| [zedwallet with TTYD](dockerfiles/zedwallet-ttyd) | Image that runs zedwallet with TTYD |

Current list of Docker Compose files (more to come soon):

| Name | Description |
| --- | --- |
| [TurtleCoind and zedwallet with TTYD](docker-compose/turtlecoind-zedwallet-ttyd) | Spins up two containers, TurtleCoind and zedwallet, and shares the terminals over the web via TTYD |

All images are stored on [Docker Hub](https://cloud.docker.com/u/andrewnk/repository/docker/andrewnk/turtlecoin)