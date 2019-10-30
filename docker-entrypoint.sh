#!/bin/sh

# Prepare /config.ini with values from env
perl -p -i -e "s{^(upstream =).*}{\1 ${UPSTREAM_FILE:-/etc/nginx/upstream/upstream.txt}}g" /config.ini
perl -p -i -e "s{^(blue =).*}{\1 ${BLUE_ENDPOINT:-blue:8081}}g" /config.ini
perl -p -i -e "s{^(green =).*}{\1 ${GREEN_ENDPOINT:-green:8082}}g" /config.ini

# Ensure app endpoint is blue
/deploy.py -d "${ACTIVE_ENDPOINT:-blue}"

# Starting nginx
nginx -g 'daemon off;'
