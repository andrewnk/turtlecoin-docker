# violetminer Docker Image

This image builds and runs [violetminer](https://github.com/turtlecoin/violetminer) on apline.

## Table of Contents
1. [Examples](#examples)

## Examples:
```
docker build -t violetminer .
docker run -it --name violetminer violetminer
```

This image is also hosted on [Docker Hub](https://hub.docker.com/r/andrewnk/turtlecoin).

To run from the Docker Hub image:

```
docker run -it --name violetminer andrewnk/turtlecoin:violetminer
```

To use from the Docker Hub image:

```
FROM andrewnk/turtlecoin:violetminer as violetminer
```
