function setup {
  source $BATS_TEST_DIRNAME/../setup.sh
}

@test "re01: Test case fails with runtime error." {
  echo "$OUT" | grep RUNTIME_ERROR
}
