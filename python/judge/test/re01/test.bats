TEST_NAME=`basename $BATS_TEST_DIRNAME`

function setup {
  source $BATS_TEST_DIRNAME/../../../../common/judge/test/setup.sh
}

@test "$TEST_NAME: Test case fails with runtime error." {
  r=`echo "$OUT" | jshon -e ruling -u`
  [ "$r" = RUNTIME_ERROR ]
}
