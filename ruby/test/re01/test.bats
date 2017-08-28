function setup {
  source $BATS_TEST_DIRNAME/../setup.sh
}

@test "re01: Test case fails with runtime error." {
  r=`echo "$OUT" | jshon -e ruling -u`
  [ "$r" = RUNTIME_ERROR ]
}
