#!/bin/sh

######################################################
# Build bitskyai/web-app
######################################################

ROOT_DIR=$(pwd)
echo "Root Folder: $ROOT_DIR"

cd bitsky-web-app
docker build -t bitskyai/web-app -f Dockerfile .