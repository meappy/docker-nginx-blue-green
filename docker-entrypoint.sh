#!/bin/sh

# Create nginx user/pass
if [ -z "${BASIC_AUTH_USERNAME}" ] || [ -z "${BASIC_AUTH_PASSWORD}" ]; then
  :
else
  printf "${BASIC_AUTH_USERNAME:-admin}:$(openssl passwd -apr1 ${BASIC_AUTH_PASSWORD:-MzlmaE1KS2RKKzByV0l2TDVNeS9ML2NU})\n" \
         > /etc/nginx/conf.d/.htpasswd
  perl -p -i -e "s{(^  \})}{    auth_basic "Realm";\n    auth_basic_user_file conf.d/.htpasswd;\n\1}g" /etc/nginx/conf.d/default.conf
fi

# Prepare /config.ini with values from env
perl -p -i -e "s{^(upstream =).*}{\1 ${UPSTREAM_FILE:-/etc/nginx/upstream/upstream.txt}}g" /config.ini
perl -p -i -e "s{^(blue =).*}{\1 ${BLUE_ENDPOINT:-blue:8081}}g" /config.ini
perl -p -i -e "s{^(green =).*}{\1 ${GREEN_ENDPOINT:-green:8082}}g" /config.ini

# Ensure app endpoint is blue
/deploy.py -d "${ACTIVE_ENDPOINT:-blue}"

# Starting nginx
nginx -g 'daemon off;'
