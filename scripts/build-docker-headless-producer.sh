#!/bin/sh

######################################################
# Build munew/headless-agent
######################################################

ROOT_DIT=$(pwd)
echo $ROOT_DIT

cd bitsky-headless-producer
docker build -t bitskyai/headless-producer -f Dockerfile .