function setup {
  ! source $BATS_TEST_DIRNAME/../setup.sh
}

function teardown {
  source $BATS_TEST_DIRNAME/../teardown.sh
}

@test "eat-cpu: We can kill sandbox." {
  docker inspect $CID | grep '"ExitCode": 137'
}

@test "eat-cpu: There are no lines of output." {
  r=$(docker logs $CID | wc -l)
  [ "$r" = 0 ]
}
