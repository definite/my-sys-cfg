### Usage: source const.sh
###     Definition of constants

: ${MSC_ETC_MSC_DIR:=/etc/my-sys-cfg}
export MSC_ETC_MSC_DIR

if [ -r $MSC_ETC_MSC_DIR/local.sh ];then
    source $MSC_ETC_MSC_DIR/local.sh
fi

### Exit Statuses
export MSC_EXIT_OK=0
export MSC_EXIT_UNHANDLED=1
export MSC_EXIT_RETURN=20
export MSC_EXIT_RETURN_FALSE=21
export MSC_EXIT_RETURN_UNCHANGED=22
export MSC_EXIT_WARNING=40
export MSC_EXIT_ERR=60
export MSC_EXIT_CRIT=80

###
### MSC_LOG_LEVEL_DICT
###     Define log levels
###     It is based on loglevel from syslog(3)
declare -A MSC_LOG_LEVEL_DICT
###
###     pending:
###         Initial level of outcome.
MSC_LOG_LEVEL_DICT['pending']=0
###
###     debug1:
###         A little bit more verbose debug messages
MSC_LOG_LEVEL_DICT['debug1']=5
###
###     debug:
###         Only useful when debugging
MSC_LOG_LEVEL_DICT['debug']=6
###
###     info:
###         User may be interested.
MSC_LOG_LEVEL_DICT['info']=7
###
###     notice:
###         User needs to see.
MSC_LOG_LEVEL_DICT['notice']=8
###
###     warning:
###         The program may still return OK, but user need to be warned.
MSC_LOG_LEVEL_DICT['warning']=9
###
###     err:
###         Error that is not severe to stop the program.
###         From this level, error messages need to be shown.
MSC_LOG_LEVEL_DICT['err']=10
###
###     crit:
###         The program should stop and return error immediately.
MSC_LOG_LEVEL_DICT['crit']=20
MSC_LOG_LEVEL_DICT['alert']=21
MSC_LOG_LEVEL_DICT['emerg']=22
export MSC_LOG_LEVEL_DICT
