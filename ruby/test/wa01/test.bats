function setup {
  source $BATS_TEST_DIRNAME/../setup.sh
}

@test "wa01: Test case is rejected." {
  echo "$OUT" | grep WRONG_ANSWER
}
