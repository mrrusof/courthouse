#!/bin/bash

SRC=/run/judge/main.rb
INP=/run/judge/in
ACT=/tmp/act
TIM=/tmp/time

/usr/bin/time --verbose -o $TIM ruby $SRC <$INP >$ACT 2>&1
echo $?
grep 'wall clock' $TIM | sed 's/.*: //'
cat $ACT
