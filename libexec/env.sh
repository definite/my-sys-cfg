### my-sys-cfg environment variables that user can override
## To source this script, via msc-env-find is recommended 

###
### MSC_ETC_MSC_DIR
###     Directory for my-sys-cfg configuration files.
###     Default: /etc/my-sys-cfg
: ${MSC_ETC_MSC_DIR:=/etc/my-sys-cfg}

### 
### MSC_LOG_FACILITY
###     Syslog facility to use for logging.
###     Default: user
: ${MSC_LOG_FACILITY:=user}
### 
### MSC_LOG_FILE
###     Log file
###     Default: empty (No log to file)
: ${MSC_LOG_FILE:=}
###
### MSC_LOG_LEVEL
###     Lowest log level to output
###     Default: notice
: ${MSC_LOG_LEVEL:=notice}
###
### MSC_LOG_PREFIX
###     Prefix string to add to each log message.
###     Default: (empty)
: ${MSC_LOG_PREFIX:=}
###
### MSC_LOG_OPTIONS
###     Extra options for logger.
###     If it has '-t <tag>' option, it takes precedence over MSC_LOG_TAG.
###
###     Default: (empty). Stderr output is controlled by MSC_LOG_STDERR.
: ${MSC_LOG_OPTIONS:=}
###
### MSC_LOG_STDERR
###     Log show in stderr
###     Default: 1 (Yes)
: ${MSC_LOG_STDERR:=1}
###
### MSC_LOG_TAG
###     Marked the log with a specified tag in logger.
###     
###     Passed as logger -t "$MSC_LOG_TAG"
###     Default: my-sys-cfg
: ${MSC_LOG_TAG:=my-sys-cfg}
