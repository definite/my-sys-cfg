### Definition of environment variables
## To source this script, via msc-env-find is recommended 

: ${MSC_ETC_MSC_DIR:=/etc/my-sys-cfg}
export MSC_ETC_MSC_DIR

: ${MSC_LOG_FACILITY:=user}
: ${MSC_LOG_LEVEL:=notice}
: ${MSC_LOG_PREFIX:=}

###
### MSC_LOG_OPTIONS
###   Options for logger. Default is '-s', i.e. also print error message to
###   stderr.
###   Default: -s
: ${MSC_LOG_OPTIONS:="-s"}
###
### MSC_LOG_TAG
###   Marked the log with a specified tag in logger.
###   From logger -t <tag>
###   Default: my-sys-cfg
: ${MSC_LOG_TAG:=my-sys-cfg}
