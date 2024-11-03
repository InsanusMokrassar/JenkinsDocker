#!/bin/bash

if [ -z "$1" ]; then
  newVersion="2.479.1"
else
  newVersion="$1"
fi

sed -i -E "s/[0-9\.]+\/jenkins.war/${newVersion}\/jenkins.war/g" Dockerfile
sed -i -E "s/version=\"[0-9\.]+\"/version=\"${newVersion}\"/g" deploy

