#!/bin/sh

######################################################
# Build munew/headless-agent
######################################################

ROOT_DIT=$(pwd)
echo $ROOT_DIT

cd dia-agents-headless
docker build -t munew/headless-agent -f Dockerfile .