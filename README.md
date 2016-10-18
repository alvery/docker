# Docker Local Development

### Prerequisities
* Install `docker-engine`: <a href="https://docker.github.io/engine/installation/">Docker engine instructions</a>

* Install `docker-compose`: <a href="https://docs.docker.com/compose/install/">Docker compose instructions</a>

Before deploying check your installation:
```
$ docker run hello-world
$ docker-compose --version
```



### Installation

1) Just execute autodeploy script and follow up the instructions:
```
$ ./autodeploy.sh
```

2) After all is done you can simply de-attach <Ctrl+C>. This will stop all containers. Now you can start them in background:
```
$ docker-compose up -d
```

3) To stop them type:
```
$ docker-compose stop
```

### Information

This autodeploy script generates:
* Docker compose file `docker-compose.yml`
* Nginx configuration based on hostname

By default nginx container is sitting on `172.20.1.2`. You can change this in `docker-compose.yml`
