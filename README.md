# Docker blue green for nginx with ngx_http_perl_module
Proof of concept for blue green proxy with nginx + ngx_http_perl_module

## Objectives
1. Start up nginx + Apache containers 
2. Setup config.ini and deploy blue or green upstream
3. Test

## Start up nginx + Apache containers
```
docker-compose up -d 
```

## Setup config.ini and deploy blue or green upstream
```
# mv config.ini.sample config.ini

# ./deploy.py -d blue 
Current deploy status: blue:8081
```

## Test
```
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
