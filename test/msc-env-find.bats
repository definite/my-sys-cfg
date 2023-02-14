setup() {
  load test_helper/common
  _common_setup
}

@test "msc-env-find" {
  MSC_BIN_DIR=
  MSC_LIBEXEC_DIR=
  MSC_ETC_DIR=
  MSC_ETC_MSC_DIR=
  run $PROJ_ROOT/bin/msc-env-find
  assert_output - <<END
MSC_BIN_DIR=$PROJ_ROOT/bin
MSC_LIBEXEC_DIR=$PROJ_ROOT/libexec
MSC_ETC_DIR=$PROJ_ROOT/etc
MSC_ETC_MSC_DIR=$PROJ_ROOT/etc/my-sys-cfg
END
}

@test "msc-env-find -f" {
  MSC_BIN_DIR=
  MSC_LIBEXEC_DIR=
  MSC_ETC_DIR=
  MSC_ETC_MSC_DIR=
  run $PROJ_ROOT/bin/msc-env-find -f
  assert_output - <<END
MSC_BIN_DIR=$PROJ_ROOT/bin
MSC_LIBEXEC_DIR=$PROJ_ROOT/libexec
MSC_ETC_DIR=$PROJ_ROOT/etc
MSC_ETC_MSC_DIR=$PROJ_ROOT/etc/my-sys-cfg
source $PROJ_ROOT/libexec/functions.sh
END
}