function setup {
  ! source $BATS_TEST_DIRNAME/../setup.sh
}

function teardown {
  source $BATS_TEST_DIRNAME/../teardown.sh
}

@test "timeout: Sandbox times out." {
  docker inspect $CID | grep '"ExitCode": 137'
}

@test "timeout: There are no lines of output." {
  r=$(docker logs $CID | wc -l)
  [ "$r" = 0 ]
}
