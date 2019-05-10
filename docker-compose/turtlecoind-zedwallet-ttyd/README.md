# TurtleCoind and zedwallet With TTYD

This is an example docker-compose file that runs TurtleCoind and zedwallet, pulled from Docker Hub, using ttyd. Communication between the two processes occurs within a docker network. 

You can view available environment variables here:
[TurtleCoind](../../dockerfiles/turtlecoind/README.md)
[zedwallet](../../dockerfiles/zedwallet/README.md)

To start the containers simply run ```docker-compose up -d```

Once the containers are running you can view the progress of TurtleCoind by browsing to http://localhost:8080 and interact with zedwallet by going to  http://localhost:8181

This setup includes a bind-mount for the two containers so that you may easily access data from both containers. In order to run TurtleCoind with a bind-mount you will need to [download the checkpoints file](https://github.com/turtlecoin/checkpoints) and add it to the directory. If you prefer to use named volumes you can change the *volume* properties to something like
```
volumes:
  turtlecoind:/home/turtlecoin
```
