#!/bin/bash

su sandbox

SRC=/input/main.rb
INP=/input/in
ACT=/tmp/act
TIM=/tmp/time

/usr/bin/time --verbose -o $TIM ruby $SRC <$INP >$ACT 2>&1
echo $?
grep 'wall clock' $TIM | sed 's/.*: //'
cat $ACT
