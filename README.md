# TurtleCoin Docker

This repo is a collection of Docker images and Docker Compose files that run a variety of TurtleCoin software. The only thing you need to get up is running is [Docker](https://docs.docker.com/install/#supported-platforms) and [Docker Compose](https://docs.docker.com/compose/install/) (if you want to run the Docker Compose files).

All images use Alpine as the base which reduces a lot of bloat, keeping the final images very small and portable.

Current list of Docker images (more to come soon):

| Name | Description |
| --- | --- |
| [Base](dockerfiles/base) | Contains all TurtleCoin binaries and is meant to be a starting point to build from |
| [Miner](dockerfiles/miner) | Runs the TurtleCoin Miner|
| [Miner with TTYD](dockerfiles/miner-ttyd) | Runs the TurtleCoin Miner with TTYD |
| [Turtle CLI py With TTYD](dockerfiles/turtle-cli-py-ttyd) | Runs Turtle CLI py With TTYD |
| [TurtleCoind](dockerfiles/turtlecoind) | Runs TurtleCoind |
| [TurtleCoind with TTYD](dockerfiles/turtlecoind-ttyd) | Runs TurtleCoind with TTYD |
| [TurtleCoind-ha](dockerfiles/turtlecoind-ha) | Runs TurtleCoind with turtlecoind-ha and pm2 |
| [TurtleCoind-ha with TTYD](dockerfiles/turtlecoind-ha-ttyd) | Runs TurtleCoind with turtlecoind-ha and pm2 on with TTYD |
| [TurtleCoin Test Suite with TTYD](dockerfiles/turtlecoin-test-suite-ttyd) | Runs TurtleCoin Test Suite with TTYD |
| [Turtle Network CLI With TTYD ](dockerfiles/turtle-network-cli-ttyd) | Runs Turtle Network CLI with TTYD |
| [TurtleCoin Wallet NodeJS With TTYD ](dockerfiles/turtlecoin-wallet-nodejs-ttyd) | Runs TurtleCoin Wallet NodeJS with TTYD |
| [violetminer](dockerfiles/violetminer) | Runs violetminer |
| [violetminer with TTYD](dockerfiles/violetminer-ttyd) | Runs violetminer with TTYD |
| [zedwallet](dockerfiles/zedwallet) | Runs zedwallet |
| [zedwallet-beta](dockerfiles/zedwallet-beta) | Runs zedwallet-beta |
| [zedwallet with TTYD](dockerfiles/zedwallet-ttyd) | Runs zedwallet with TTYD |
| [zedwallet-beta with TTYD](dockerfiles/zedwallet-beta-ttyd) | Runs zedwallet-beta with TTYD |

Current list of Docker Compose files (more to come soon):

| Name | Description |
| --- | --- |
| [TurtleCoind and zedwallet with TTYD](docker-compose/turtlecoind-zedwallet-ttyd) | Spins up two containers, TurtleCoind and zedwallet, and shares the terminals over the web via TTYD |

All images are stored on [Docker Hub](https://hub.docker.com/r/andrewnk/turtlecoin)