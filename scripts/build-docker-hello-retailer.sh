#!/bin/sh

######################################################
# Build bitskyai/hello-retailer
######################################################

ROOT_DIR=$(pwd)
echo "Root Folder: $ROOT_DIR"

cd bitsky-hello-retailer
docker build -t bitskyai/hello-retailer -f Dockerfile .