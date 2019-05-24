# TurtleCoin Test Suite With TTYD Docker Image

This is a dockerization of the [TurtleCoin Test Suite](https://github.com/turtlecoin/turtlecoin-test-suite) running on apline with ttyd. The process is run within tmux to persist the session in case the page reloads or crashes.

## Table of Contents
1. [Examples](#examples)
2. [Build Args/Env Variables](#build-arguments-and-environment-variables)

## Examples:
```
docker build -t turtlecoin-test-suite-ttyd .
docker run -d -p 7681:7681 --name turtlecoin-test-suite-ttyd turtlecoin-test-suite-ttyd
```

To use the test suite navigate to http://localhost:7681 (or whatever port you pass in, e.g. ```-p 8080:7681```)


Accessing the web terminal with a username and password:
```
docker run -d -p 7681:7681 -e WEB_USERNAME=Slow -e WEB_PASSWORD=AndSteady --name turtlecoin-test-suite-ttyd turtlecoin-test-suite-ttyd
```

This image is also hosted on [Docker Hub](https://hub.docker.com/r/andrewnk/turtlecoin). 

To run from the Docker Hub image:

```
docker run -d -p 7681:7681 --name turtlecoin-test-suite-ttyd andrewnk/turtlecoin:turtlecoin-test-suite-ttyd
```

To use from the Docker Hub image:

```
FROM andrewnk/turtlecoin:turtlecoin-test-suite-ttyd as turtlecoin-test-suite-ttyd
```

## Build Arguments and Environment Variables:

| Name | Default | Function |
| --- | --- | --- |
| WEB_USERNAME |  | Username to access the web terminal |
| WEB_PASSWORD |  | Password to access the web terminal |
