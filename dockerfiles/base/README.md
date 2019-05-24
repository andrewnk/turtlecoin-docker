# TurtleCoin Base Docker Image

This image compiles all TurtleCoin binaries and is meant to be a starting point to build from. We first use Alpine to compile the binaries then, to minimize the final image, copy them to a Scratch image. This image currently only works with the development branch.

## Table of Contents
1. [Examples](#examples)
2. [Build Args/Env Variables](#build-arguments-and-environment-variables)

## Examples:
```
docker build -t turtlecoin-base .
docker build --build-arg BRANCH=development -t turtlecoin-base .
```

To copy a binary into your own image, use multi-stage builds like this:
```
FROM turtlecoin-base as base

FROM alpine

#copy binary from base
COPY --from=base /zedwallet /my/location
```

This image is also hosted on [Docker Hub](https://hub.docker.com/r/andrewnk/turtlecoin). To copy from the Docker Hub image:

```
FROM andrewnk/turtlecoin:base as base
```

## Build Arguments and Environment Variables:

| Name | Default | Function |
| --- | --- | --- |
| BRANCH | development | Sets the git branch to build from |
| ENABLE_SSL | false | Whether or not to build with ssl support |
