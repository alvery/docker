# Docker Local Development

### Prerequisities
* Install docker-engine
* Install docker-compose

### Installation

1) Just execute autodeploy script and follow up the instructions:
```
$ ./autodeploy.sh
```

3) After all is done you can simply de-attach <Ctrl+C>. This will stop all containers. Now you can start them in background:
```
$ docker-compose up -d
```

4) To stop them type:
```
$ docker-compose stop
```

### Information

This autodeploy script generates:
* Docker compose file `docker-compose.yml`
* Nginx configuration based on hostname

By default nginx container is sitting on `172.20.1.2`. You can change this in `docker-compose.yml`
