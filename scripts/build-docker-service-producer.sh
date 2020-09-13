#!/bin/sh

######################################################
# Build bitskyai/service-producer
######################################################

ROOT_DIR=$(pwd)
echo "Root Folder: $ROOT_DIR"

cd bitsky-service-producer
docker build -t bitskyai/service-producer -f Dockerfile .