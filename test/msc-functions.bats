setup() {
  load test_helper/common
  _common_setup
}

# bats file_tags=function

@test functions {
  run type -t msc_log
  assert_output "function"
}

@test msc_apply {
  local MscTestFile=$(mktemp /tmp/test-msc-XXXXXX)
  echo -e  "_msc_test_msc_apply_ls=/bin/ls\n_msc_test_msc_apply_cat=/bin/cat" > $MscTestFile
  msc_apply alias $MscTestFile
  run alias _msc_test_msc_apply_ls
  assert_output "alias _msc_test_msc_apply_ls='/bin/ls'"
  run alias _msc_test_msc_apply_cat
  assert_output "alias _msc_test_msc_apply_cat='/bin/cat'"
  unalias _msc_test_msc_apply_ls _msc_test_msc_apply_cat
  rm -f $MscTestsFile
}

# Whether msc_array_get_value work for current shell
@test msc_array_get_value {
  declare -A TestArray
  TestArray[Sunday]=0
  TestArray['Tues day']=2
  run msc_array_get_value TestArray Sunday
  assert_output '0' 
  run msc_array_get_value TestArray 'Tues day'
  assert_output '2'
}

@test msc_file_list_effective {
  run msc_file_list_effective $TEST_DATA_DIR/msc_file_list_effective.ini
  assert_output 'line 3
line #4
 line 10'
}
