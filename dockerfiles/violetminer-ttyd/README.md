# violetminer with TTYD Docker Image

This image builds and runs [violetminer](https://github.com/turtlecoin/violetminer) on apline using ttyd.

## Table of Contents
1. [Examples](#examples)

## Examples:
```
docker build -t violetminer-ttyd .
docker run -d -p 7681:7681 --name violetminer-ttyd violetminer-ttyd
```

To use violetminer navigate to http://localhost:7681 (or whatever port you pass in, e.g. ```-p 8080:7681```)

Accessing the web terminal with a username and password:
```
docker run -d -p 7681:7681 -e WEB_USERNAME=Slow -e WEB_PASSWORD=AndSteady --name violetminer-ttyd violetminer-ttyd

This image is also hosted on [Docker Hub](https://hub.docker.com/r/andrewnk/turtlecoin).

To run from the Docker Hub image:

```
docker run -it --name violetminer-ttyd andrewnk/turtlecoin:violetminer-ttyd
```

To use from the Docker Hub image:

```
FROM andrewnk/turtlecoin:violetminer-ttyd as violetminer-ttyd
```
