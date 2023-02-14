_common_setup(){
  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  PROJ_ROOT="$( cd "$( dirname "$BATS_TEST_FILENAME" )/.." >/dev/null 2>&1 && pwd )"
  # make executables in src/ visible to PATH
  PATH="$PROJ_ROOT/libexec:$PROJ_ROOT/bin:$PATH"
  load "test_helper/bats-support/load"
  load "test_helper/bats-assert/load"
}
