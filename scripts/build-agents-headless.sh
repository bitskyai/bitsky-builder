#!/bin/sh

######################################################
# Build munew-agents-headless
######################################################

ROOT_DIT=$(pwd)
echo $ROOT_DIT

cd dia-agents-headless
docker build -t munew/agents-headless -f Dockerfile .