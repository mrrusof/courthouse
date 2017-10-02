#!/bin/bash

IMAGE=judge
REPO=mrrusof/$IMAGE
JUDGE_TIMEOUT=${JUDGE_TIMEOUT:-10}

docker run \
       --interactive \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       --env JUDGE=$JUDGE \
       --env JUDGE_TIMEOUT=$JUDGE_TIMEOUT \
       --rm \
       $REPO
