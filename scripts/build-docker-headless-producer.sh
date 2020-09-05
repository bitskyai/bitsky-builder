#!/bin/sh

######################################################
# Build bitskyai/headless-producer
######################################################

ROOT_DIR=$(pwd)
echo "Root Folder: $ROOT_DIR"

cd bitsky-headless-producer
docker build -t bitskyai/headless-producer -f Dockerfile .