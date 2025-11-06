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
### MSC_LOG_LEVEL
###     Minimum log level to log
###     Default: notice
: ${MSC_LOG_LEVEL:=notice}
### MSC_LOG_PREFIX
###     Prefix string to add to each log message.
###     Default: (empty)
: ${MSC_LOG_PREFIX:=}
###
### MSC_LOG_OPTIONS
###     Options for logger. 
###     If it has '-t <tag>' option, it takes precedence over MSC_LOG_TAG.
###      
###     Default: -s (print to stderr)
: ${MSC_LOG_OPTIONS:="-s"}
###
### MSC_LOG_TAG
###     Marked the log with a specified tag in logger.
###     
###     Passed as logger -t "$MSC_LOG_TAG"
###     Default: my-sys-cfg
: ${MSC_LOG_TAG:=my-sys-cfg}
