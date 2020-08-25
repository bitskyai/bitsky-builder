#!/bin/sh

######################################################
# Build munew/engine-ui
######################################################

ROOT_DIT=$(pwd)
echo $ROOT_DIT

cd munew-engine-ui
docker build -t munew/engine-ui -f Dockerfile .