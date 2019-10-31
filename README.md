# Docker blue green upstreams for nginx with ngx_http_perl_module
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/meappy/docker-nginx-blue-green/graphs/commit-activity) [![Join the chat at https://gitter.im/docker-nginx-blue-green](https://badges.gitter.im/docker-nginx-blue-green.svg)](https://gitter.im/docker-nginx-blue-green) [![Build Status](https://travis-ci.org/meappy/docker-nginx-blue-green.svg?branch=master)](https://travis-ci.org/meappy/docker-nginx-blue-green)

Proof of concept for blue-green upstream proxy with nginx + ngx_http_perl_module.

## Docker run
This method pulls the latest image from Docker Hub. Ready for use as a stateless container proxy for use on container platforms like ECS, EKS

### Objectives
1. Set up environment file and docker run
2. Print current upstream
2. Switch upstream
4. Clean up container

### Copy [sample environment file](https://bit.ly/2WuaNFB), modify values to suit, and docker run
```
# cp .env.sample .env
# docker run -p 80:80 -d --name nginx --env-file ./.env meappy/nginx-blue-green
```

### Print current upstream
```
# docker exec -it nginx /deploy.py -p
Current deploy status: apache:80
```

### Switch upstream
```
# docker exec -it nginx /deploy.py -d green
Current deploy status: apache:81
```

### Clean up container
```
# docker stop nginx
# docker rm nginx
```
&nbsp;  
## Docker Compose method
This method pulls an nginx image from Docker Hub. Docker volume is used with deploy script. Good for use as stateful setup where persistent storage is used.

### Objectives
1. Start up nginx + Apache containers 
2. Setup config.ini and deploy blue or green upstream
3. Test

### Start up nginx + Apache containers
```
docker-compose up -d 
```

### Setup config.ini and deploy blue or green upstream
```
# cp config.ini.sample config.ini

# ./deploy.py -d blue 
Current deploy status: blue:8081
```

### Test
```
# ./deploy.py -p 
Current deploy status: blue:8081

# curl -H 'Host: poc' -k -iL http://127.0.0.1
HTTP/1.1 200 OK
Server: nginx/1.15.12
Date: Thu, 23 May 2019 07:19:00 GMT
Content-Type: text/html
Content-Length: 45
Connection: keep-alive
Last-Modified: Mon, 11 Jun 2007 18:53:14 GMT
ETag: "2d-432a5e4a73a80"
Accept-Ranges: bytes

<html><body><h1>It works!</h1></body></html>
```
