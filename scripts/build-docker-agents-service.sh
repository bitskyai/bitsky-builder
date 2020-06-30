#!/bin/sh

######################################################
# Build munew/service-agent
######################################################

ROOT_DIT=$(pwd)
echo $ROOT_DIT

cd dia-agents-service
docker build -t munew/service-agent -f Dockerfile .