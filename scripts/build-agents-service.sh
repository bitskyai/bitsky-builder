#!/bin/sh

######################################################
# Build munew-agents-service
######################################################

ROOT_DIT=$(pwd)
echo $ROOT_DIT

cd dia-agents-service
docker build -t munew/service-agent -f Dockerfile .