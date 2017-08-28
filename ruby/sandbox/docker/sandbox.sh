#!/bin/bash

# Get rid of that 'sudo: unable to resolve host XXXX' bullshit
echo "127.0.0.1 `cat /etc/hostname`" >/etc/hosts

RAW=/tmp/input.json
SRC=/tmp/program.rb
INP=/tmp/input
ACT=/tmp/act
TIM=/tmp/time

cat >$RAW
jshon -e program -u <$RAW >$SRC
jshon -e input -u <$RAW >$INP

sudo --host=127.0.0.1 --user=sandbox \
    /usr/bin/time --verbose -o $TIM ruby $SRC <$INP >$ACT 2>&1

<<<'{}' \
jshon -n "$?" -i exitCode \
      -s "`grep 'wall clock' $TIM | sed 's/.*: //'`" -i wallTime \
      -s "`cat $ACT`" -i actualOutput
