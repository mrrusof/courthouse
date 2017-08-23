function setup {
  source $BATS_TEST_DIRNAME/../setup.sh
}

@test "ac01: Test case is accepted." {
  echo "$OUT" | grep ACCEPTED
}
