#!/bin/bash
set -e
EXPECTED="It works!"
if [[ $(curl -s -H 'Host: poc' 127.0.0.1 | grep "${EXPECTED}") ]]; then
  echo "Test passed"
  exit 0
else
  echo "Test failed"
  exit 1
fi
