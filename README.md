# janus-docker
Simple Janus RTC Server Docker for Development Pruposes

This Docker image should not be used for Production Systems, all config sets are default such as described here: https://janus.conf.meetecho.com/docs/README.html

You are allowed to fork this repo in order to update with your own settings

# missing-files (1)
In order to access Janus HTTPS Rest API and Demos you should generate your own fake .crt and .prt files and insert them into root folder before building this docker image

If you doens't need to access the secure features simply comment these two instructions from Dockerfile before building

```
#COPY localhost.crt /etc/ssl/.
#COPY localhost.key /etc/ssl/.
```

# docker-build (2)
In root folder execute

```
#docker build -t <yourimage>:<yourversion> .
docker build -t janus:dev .
```

# running your container (3)
```
docker run -d -p8088:8088 -p8089:8089 -p443:443 --name janus janus:dev
```

# accessing the demos
https://localhost/demos.html

# disclaimer
I do not own the Janus RTC Server Software, this repo is simply a docker image builded in order for me to test-it, the software belongs to Meetecho https://janus.conf.meetecho.com/

# troubleshooting
This image is free for use, that being said i do not provide any support for it.

