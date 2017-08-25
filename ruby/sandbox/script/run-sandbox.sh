#!/bin/bash

JUDGE=$1
INPUT_DIR=$2

docker run \
       -d \
       --memory=100m \
       --oom-kill-disable \
       --cpus=0.75 \
       --network=none \
       -v $INPUT_DIR:/input:ro \
       $JUDGE-sandbox
