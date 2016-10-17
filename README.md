# Docker Local Development

### Prerequisities
* Install docker-engine
* Install docker-compose

### Installation

1) Open docker-compose.yml and find `app` section. In the `volumes` subsection change path to your project root directory. This path will be mounted to the virtualhost ```/var/www/html```.
```
app:
    build: ./app/
    volumes:
      - ~/PhpstormProjects/rline/mom_backend/:/var/www/html
    networks:
      app_subnet:
        ipv4_address: 172.20.1.6
    container_name: app
```


2) Run docker-compose and wait until all done.
```
$ docker-compose up
```

3) After that you can simply de-attach <Ctrl+C>. This will stop all containers. Now you can start them in background:
```
$ docker-compose up -d
```

4) As all containers have static IP's you should add nginx to /etc/hosts. You can add it manually or using network.sh:
```
$ ./network.sh
```
OR
```
172.20.1.2 my.app
```
By default nginx container is sitting on 172.20.1.2. You can change this in `docker-compose.yml`
