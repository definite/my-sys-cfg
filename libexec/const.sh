### Definition of constants
## To source this script, via msc-env-find is recommended 
MSC_VERSION=2.1.0

declare -A MscExitMessageDict

### Exit Status
###     MSC_EXIT_OK(0)
###        Run successfully
export MSC_EXIT_OK=0
MscExitMessageDict[$MSC_EXIT_OK]="Done"
###
###     MSC_EXIT_RETURN_UNCHANGED(1)
###         Indicate that no change is done.
###         e.g. A recod to be created already exists, no need to change.
export MSC_EXIT_RETURN_UNCHANGED=1
MscExitMessageDict[$MSC_EXIT_RETURN_UNCHANGED]="Unchanged"
###
###     MSC_EXIT_RETURN_FALSE(2)
###         Nothing wrong, just a return value that means false.
###         Such as query whether a record exists.
export MSC_EXIT_RETURN_FALSE=2
MscExitMessageDict[$MSC_EXIT_RETURN_FALSE]="Return false"
###
###     MSC_EXIT_RETURN(30)
###         Nothing wrong, just need to return from execution.
export MSC_EXIT_RETURN=30
MscExitMessageDict[$MSC_EXIT_RETURN]="Generic Return"
###
###     MSC_EXIT_WARNING(60)
###         Something should be fixed, but can continue running
export MSC_EXIT_WARNING=60
MscExitMessageDict[$MSC_EXIT_WARNING]="Generic Warning"
###
###     MSC_EXIT_ERR(90)
###         Something wrong, thus program will fail eventurally.
export MSC_EXIT_ERR=90
MscExitMessageDict[$MSC_EXIT_ERR]="Generic Error"
###
###     MSC_EXIT_CRIT_ARGUMENTS_INVALID(91)
###         Invalid argument or option
export MSC_EXIT_CRIT_ARGUMENTS_INVALID=91
MscExitMessageDict[$MSC_EXIT_CRIT_ARGUMENTS_INVALID]="Arguments Invalid"
###
###     MSC_EXIT_CRIT_DEPENDENCIES_MISSING(92)
###         Dependencies missing, such as programs are not installed.
export MSC_EXIT_CRIT_DEPENDENCIES_MISSING=92
MscExitMessageDict[$MSC_EXIT_CRIT_DEPENDENCIES_MISSING]="Dependencies Missing"
###
###     MSC_EXIT_CRIT_DEVICE_MISSING(93)
###         Device missing, such as NIC missing.
export MSC_EXIT_CRIT_DEVICE_MISSING=93
MscExitMessageDict[$MSC_EXIT_CRIT_DEVICE_MISSING]="Device Missing"
###
###     MSC_EXIT_CRIT(120)
###         Generic Critical Error that must stop immediately
export MSC_EXIT_CRIT=120
MscExitMessageDict[$MSC_EXIT_CRIT]="Generic Critical"
export MscExitMessageDict

###
### Environment
###     MSC_LOG_LEVEL_DICT
###         Define log levels
###         It is based on loglevel from syslog(3)
declare -A MSC_LOG_LEVEL_DICT
###
###         pending:
###             Initial level of outcome.
MSC_LOG_LEVEL_DICT['pending']=0
###
###         debug1:
###             A little bit more verbose debug messages
MSC_LOG_LEVEL_DICT['debug1']=5
###
###         debug:
###             Only useful when debugging
MSC_LOG_LEVEL_DICT['debug']=6
###
###         info:
###             User may be interested.
MSC_LOG_LEVEL_DICT['info']=7
###
###         notice:
###             User needs to see.
MSC_LOG_LEVEL_DICT['notice']=10
###
###         warning:
###             The program may still return OK, but user need to be warned.
MSC_LOG_LEVEL_DICT['warning']=$MSC_EXIT_WARNING
###
###         err:
###             Error that is not severe to stop the program.
###             From this level, error messages need to be shown.
MSC_LOG_LEVEL_DICT['err']=$MSC_EXIT_ERR
###
###         crit:
###             The program should stop and return error immediately.
MSC_LOG_LEVEL_DICT['crit']=$MSC_EXIT_CRIT
MSC_LOG_LEVEL_DICT['alert']=$((MSC_EXIT_CRIT + 1))
MSC_LOG_LEVEL_DICT['emerg']=$((MSC_EXIT_CRIT + 2))
export MSC_LOG_LEVEL_DICT
