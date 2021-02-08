### Usage: source const.sh
###     Definition of constants
MSC_VERSION=0.8.0

: ${MSC_ETC_MSC_DIR:=/etc/my-sys-cfg}
export MSC_ETC_MSC_DIR

if [ -r $MSC_ETC_MSC_DIR/local.sh ]; then
    source $MSC_ETC_MSC_DIR/local.sh
fi

declare -A MscExitMessageDict

### Exit Statuses
###
###    MSC_EXIT_OK(0)
###        Run successfully
export MSC_EXIT_OK=0
MscExitMessageDict[$MSC_EXIT_OK]=" Done."
###
###     MSC_EXIT_RETURN_UNCHANGED(1)
###         Indicate that no change is done.
###         e.g. A recod to be created already exists, no need to change.
export MSC_EXIT_RETURN_UNCHANGED=1
MscExitMessageDict[$MSC_EXIT_RETURN_UNCHANGED]=" Unchanged."
###
###     MSC_EXIT_RETURN_FALSE(2)
###         Nothing wrong, just a return value that means false.
###         Such as query whether a record exists.
export MSC_EXIT_RETURN_FALSE=2
MscExitMessageDict[$MSC_EXIT_RETURN_FALSE]=" Return false."
###
###     MSC_EXIT_RETURN(30)
###         Nothing wrong, just need to return from execution.
export MSC_EXIT_RETURN=30
MscExitMessageDict[$MSC_EXIT_RETURN]=" Return."
###
###     MSC_EXIT_WARNING(60)
###         Something should be fixed, but can continue running
export MSC_EXIT_WARNING=60
MscExitMessageDict[$MSC_EXIT_WARNING]="[Warning]"
###
###     MSC_EXIT_ERR(90)
###         Something wrong, thus program will fail eventurally.
export MSC_EXIT_ERR=90
MscExitMessageDict[$MSC_EXIT_ERR]="[ERR]"
###
###     MSC_EXIT_CRIT_ARGUMENTS_INVALID(91)
###         Invalid argument or option
export MSC_EXIT_CRIT_ARGUMENTS_INVALID=91
MscExitMessageDict[$MSC_EXIT_CRIT_ARGUMENTS_INVALID]="[CRIT] Arguments Invalid:"
###
###     MSC_EXIT_CRIT_DEPENDENCIES_MISSING(92)
###         Dependencies missing, such as programs are not installed.
export MSC_EXIT_CRIT_DEPENDENCIES_MISSING=92
MscExitMessageDict[$MSC_EXIT_CRIT_DEPENDENCIES_MISSING]="[CRIT] Dependencies Missing:"
###
###     MSC_EXIT_CRIT(120)
###         Generic Critical Error that must stop immediately
export MSC_EXIT_CRIT=120
MscExitMessageDict[$MSC_EXIT_CRIT]="[CRIT]"
export MscExitMessageDict

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
MSC_LOG_LEVEL_DICT['notice']=10
###
###     warning:
###         The program may still return OK, but user need to be warned.
MSC_LOG_LEVEL_DICT['warning']=$MSC_EXIT_WARNING
###
###     err:
###         Error that is not severe to stop the program.
###         From this level, error messages need to be shown.
MSC_LOG_LEVEL_DICT['err']=$MSC_EXIT_ERR
###
###     crit:
###         The program should stop and return error immediately.
MSC_LOG_LEVEL_DICT['crit']=$MSC_EXIT_CRIT
MSC_LOG_LEVEL_DICT['alert']=$((MSC_EXIT_CRIT + 1))
MSC_LOG_LEVEL_DICT['emerg']=$((MSC_EXIT_CRIT + 2))
export MSC_LOG_LEVEL_DICT
