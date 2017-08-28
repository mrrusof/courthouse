function setup {
  source $BATS_TEST_DIRNAME/../setup.sh
}

@test "to01: Test case times out." {
  r=`echo "$OUT" | jshon -e ruling -u`
  [ "$r" = TIMEOUT ]
}
