# Docker blue green for nginx with ngx_http_perl_module
Proof of concept for blue green proxy with nginx + ngx_http_perl_module

## Objectives
1. Start up nginx + Apache containers 
2. Modify upstream.txt for blue or green redirection
3. Test

## Start up nginx + Apache containers
```
docker-compose up -d 
```

## Modify upstream.txt for blue or green redirection
```
echo 'apache' > nginx/assets/upstream/upstream.txt 
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
