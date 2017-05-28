#!/bin/bash

docker run --rm --network=none -v `pwd`:/run/judge:ro ruby-judge $JUDGE_TIMEOUT
