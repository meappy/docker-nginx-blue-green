FROM nginx:alpine-perl

# Build arguments
ARG NGINX_UPSTREAM_DIR
ARG NGINX_PERL_LIB_DIR
ARG NGINX_CONF_FILE

# Install python
RUN apk add --update \
    python

# Copy nginx files
COPY ${NGINX_UPSTREAM_DIR:-./nginx/assets/upstream} /etc/nginx/upstream
COPY ${NGINX_PERL_LIB_DIR:-./nginx/assets/perl} /etc/nginx/perl
COPY ${NGINX_CONF_FILE:-./nginx/assets/nginx.conf} /etc/nginx/nginx.conf

# Build conf.d/default.conf
RUN { \
    echo "server {"; \
    echo "  listen 80 default_server;"; \
    echo "  listen [::]:80;"; \
    echo ""; \
    echo "  server_name _;"; \
    echo ""; \
    echo "  location ~ / {"; \
    echo "    resolver 127.0.0.11 ipv6=off;"; \
    echo "    set \$upstream \${nginx_proxy_pass_upstream};"; \
    echo "    proxy_set_header Host \$host;"; \
    echo "    proxy_set_header X-Real-IP \$remote_addr;"; \
    echo "    proxy_pass http://\$upstream\$request_uri;"; \
    echo "    client_max_body_size 256m;"; \
    echo "    proxy_read_timeout 300s;"; \
    echo "  }"; \
    echo "}"; \
    } > /etc/nginx/conf.d/default.conf

# Build /config.ini for deploy script
RUN { \
    echo "[config]"; \
    echo "upstream = nginx/assets/upstream/upstream.txt"; \ 
    echo "[deploy]"; \ 
    echo "blue = blue:8081"; \ 
    echo "green = green:8082"; \ 
    } > /config.ini

# Setup deploy script
COPY ./deploy.py /
RUN chmod +x /deploy.py

# Copy entrypoint
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD /entrypoint.sh
