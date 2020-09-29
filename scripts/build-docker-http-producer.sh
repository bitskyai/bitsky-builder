#!/bin/sh

######################################################
# Build bitskyai/http-producer
######################################################

ROOT_DIR=$(pwd)
echo "Root Folder: $ROOT_DIR"

cd bitsky-http-producer
docker build -t bitskyai/http-producer -f Dockerfile .