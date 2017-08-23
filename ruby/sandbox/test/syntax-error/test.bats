function setup {
  source $BATS_TEST_DIRNAME/../setup.sh
}

function teardown {
  source $BATS_TEST_DIRNAME/../teardown.sh
}

@test "syntax-error: There are 3 lines of output." {
  r=$(docker logs $CID | wc -l)
  [ "$r" = 3 ]
}

@test "syntax-error: First line of output is exit code 1." {
  r=$(docker logs $CID | head -n 1)
  [ "$r" = 1 ]
}

@test "syntax-error: Second line of output is time." {
  r=$(docker logs $CID | head -n 2 | tail -n 1)
  grep '^[0-9]:[0-9][0-9]\.[0-9][0-9]$' <<<"$r"
}

@test "syntax-error: Third line of output is syntax error." {
  r=$(docker logs $CID | tail -n 1)
  e="/input/main.rb:1:in \`<main>': undefined local variable or method \`bla' for main:Object (NameError)"
  [ "$r" = "$e" ]
}
