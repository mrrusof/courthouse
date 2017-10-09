TEST_NAME=`basename $BATS_TEST_DIRNAME`

function setup {
  source $BATS_TEST_DIRNAME/../../../../common/sandbox/test/setup.sh
}

function teardown {
  source $BATS_TEST_DIRNAME/../../../../common/sandbox/test/teardown.sh
}

@test "$TEST_NAME: run-sandbox.sh times out." {
  [ "$EC" = 137 ]
}

@test "$TEST_NAME: There are no lines of output." {
  r=$(docker logs $CID | wc -l)
  [ "$r" = 0 ]
}

@test "$TEST_NAME: Sandbox is still running after run-sandbox.sh exits." {
  docker ps | grep $CID
}

@test "$TEST_NAME: Sandbox is using more than 99% of allowed memory." {
  r=$(docker stats --no-stream $CID | tail -n 1 | awk '{print $6}' | sed 's/\.[0-9]\+%//')
  [ "$r" = 99 ]
}

@test "$TEST_NAME: We can remove sandbox." {
  $SCRIPT_DIR/remove-sandbox.sh
  ! docker ps | grep $CID
}
