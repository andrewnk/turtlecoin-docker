# TurtleCoin Base Docker Image

This image compiles TurtleCoind and zedwallet and is meant to be a starting point to build from. We first use Ubuntu to compile the binaries then, to minimize the final image, copy them to a Scratch image.

To copy a binary into your own image, use multi stage-builds like this:
```
FROM turtlecoin-base as base

FROM alpine

#copy binary from base
COPY --from=base /zedwallet /my/location
```

Build Arguments/Environment Variables:

| Name | Default | Function |
| --- | --- | --- |
| BRANCH | Master | Sets the git branch to build from |

Build Examples:
```docker build -t turtlecoin-base .```
```docker build --build-arg BRANCH=development -t turtlecoin-base .```