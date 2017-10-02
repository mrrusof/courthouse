TEST_NAME=`basename $BATS_TEST_DIRNAME`

function setup {
  source $BATS_TEST_DIRNAME/../../../../common/judge/test/setup.sh
}

@test "$TEST_NAME: Test case times out." {
  r=`echo "$OUT" | jshon -e ruling -u`
  [ "$r" = TIMEOUT ]
}
