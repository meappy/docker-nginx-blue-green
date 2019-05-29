#!/bin/bash

set -e

EXPECTED="It works!"

cp -f config.ini.sample config.ini
sed -i 's/blue:8081/apache/' config.ini
ls -ld config.ini
python deploy.py -d blue

if [[ $(curl -s -H 'Host: poc' 127.0.0.1 | grep "${EXPECTED}") ]]; then
  echo "Test passed"
  exit 0
else
  echo "Test failed"
  exit 1
fi
