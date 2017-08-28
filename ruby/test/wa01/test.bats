function setup {
  source $BATS_TEST_DIRNAME/../setup.sh
}

@test "wa01: Test case is rejected." {
  r=`echo "$OUT" | jshon -e ruling -u`
  [ "$r" = WRONG_ANSWER ]
}
