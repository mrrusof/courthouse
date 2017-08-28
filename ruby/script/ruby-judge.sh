#!/bin/bash

# Environment
JUDGE_TIMEOUT=${JUDGE_TIMEOUT:-10}

docker run \
       --interactive \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       --env JUDGE_TIMEOUT=$JUDGE_TIMEOUT \
       --rm \
       ruby-judge
