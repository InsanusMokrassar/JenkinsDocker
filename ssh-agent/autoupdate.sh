#!/bin/bash

if [ -z "$1" ]; then
  newVersion="5.38.0"
else
  newVersion="$1"
fi

sed -i -E "s/ssh-agent:[0-9\.]+/ssh-agent:${newVersion}/g" Dockerfile
sed -i -E "s/version=\"[0-9\.]+\"/version=\"${newVersion}\"/g" deploy

