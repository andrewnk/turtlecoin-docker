# Turtle CLI py With TTYD Docker Image

This is a dockerized version of the [Turtle CLI py](https://github.com/turtlecoin/turtlecoin-cli-py) running on apline with ttyd. The process is run within tmux to persist the session in case the page reloads or crashes.

## Table of Contents
1. [Examples](#examples)
2. [Build Args/Env Variables](#build-arguments-and-environment-variables)

## Examples:
```
docker build -t turtle-cli-py-ttyd .
docker run -d -p 7681:7681 --name turtle-cli-py-ttyd turtle-cli-py-ttyd
```

To use the test suite navigate to http://localhost:7681 (or whatever port you pass in, e.g. ```-p 8080:7681```)

To use Turtle CLI py, [check out some of the commands](https://github.com/turtlecoin/turtlecoin-cli-py)

Accessing the web terminal with a username and password:
```
docker run -d -p 7681:7681 -e WEB_USERNAME=Slow -e WEB_PASSWORD=AndSteady --name turtle-cli-py-ttyd turtle-cli-py-ttyd
```

This image is also hosted on [Docker Hub](https://hub.docker.com/r/andrewnk/turtlecoin). 

To run from the Docker Hub image:

```
docker run -d -p 7681:7681 --name turtle-cli-py-ttyd andrewnk/turtlecoin:turtle-cli-py-ttyd
```

To use from the Docker Hub image:

```
FROM andrewnk/turtlecoin:turtle-cli-py-ttyd as turtle-cli-py-ttyd
```

## Build Arguments and Environment Variables:

| Name | Default | Function |
| --- | --- | --- |
| BRANCH | master | The branch to clone |
| WEB_USERNAME |  | Username to access the web terminal |
| WEB_PASSWORD |  | Password to access the web terminal |
