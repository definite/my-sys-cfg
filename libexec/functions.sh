### source this script for common functions and environment variables

: ${MSC_LIBEXEC_DIR:=/usr/libexec/my-sys-cfg}
export MSC_LIBEXEC_DIR

source $MSC_LIBEXEC_DIR/const.sh

: ${MSC_LOG_FACILITY:=user}
: ${MSC_LOG_LEVEL:=info}
: ${MSC_LOG_PREFIX:=}
###
### MSC_LOG_TAG
###     Marked the log with a specified tag.
###     Default: my-sys-cfg
: ${MSC_LOG_TAG:=my-sys-cfg}

##
## MscLogWorstLevel
##     Worst (Biggest) status code encountered
##     This is mainly for the log level 'error', which means the eventually
##     the program will fail, but no need to exit immediately.
MscLogWorstLevel=$MSC_EXIT_OK
MscExitMsg=

### msc_log <msg> [logLevel [logger options...]]
###   Log messages with given level
###
###   Arguments:
###     msg: message to log
###     level: refer const.sh or syslog(3)
###     logger-options: other option to pass to logger
###   Environments:
###     MSG_LOG_TAG: Tag the log message

msc_log() {
    local msg="$1"
    shift
    local logLevel=$MSC_LOG_LEVEL
    if [ -n "${1:-}" ]; then
        logLevel=$1
        shift
    fi
    logger ${MSC_LOG_TAG:+-t $MSC_LOG_TAG} -p "$MSC_LOG_FACILITY.$logLevel" "$MSC_LOG_PREFIX$msg" "$@"
}

### msc_exit_print_error
###   print error when program exit
###   Insert "trap msc_exit_print_error EXIT" to activate the function
msc_exit_print_error() {
    local exitStatus=${?:-$MscLogWorstLevel}
    if [[ -n "${exitStatus-}" ]]; then
        case $exitStatus in
        $MSC_EXIT_OK)
            msc_log "Done." debug
            ;;
        $MSC_EXIT_UNHANDLED)
            msc_log "Unhandled. ${MscExitMsg}"
            ;;
        $MSC_EXIT_RETURN_FALSE)
            msc_log "Return false. ${MscExitMsg}"
            ;;
        $MSC_EXIT_RETURN_UNCHANGED)
            msc_log "Unchanged. ${MscExitMsg}"
            ;;
        $MSC_EXIT_WARNING)
            msc_log "[WARNING] ${MscExitMsg}"
            ;;
        $MSC_EXIT_ERR)
            msc_log "[ERR] ${MscExitMsg}"
            ;;
        $MSC_EXIT_CRIT)
            msc_log "[CRIT] ${MscExitMsg}"
            ;;
        $MSC_EXIT_CRIT_INVALID_ARGUMENT)
            msc_log "[CRIT] Invalid argument or option: ${MscExitMsg}"
            ;;
        $MSC_EXIT_CRIT_DEPENDENCIES_MISSING)
            msc_log "[CRIT] Dependencies missing: ${MscExitMsg}"
            ;;
        *)
            msc_log "Unexpected Exit Code $exitStatus. ${MscExitMsg}" alert
            ;;
        esac
    fi
    exit ${exitStatus}
}

###
### msc_fail <msg> <logLevel>
###     Indicate something is wrong.
###     Exit program if logLevel is equal or larger than MSC_LOG_LEVEL_DICT['crit']
msc_fail() {
    local msg="$1"
    local logLevel=$2
    if [[ $logLevel -ge ${MSC_LOG_LEVEL_DICT['crit']} ]]; then
        MscExitMsg="$2"
        ## Should be handle by msc_exit_print_error
        exit $logLevel
    else
        ## Not yet exit
        msc_log "$msg" $logLevel
        if [ $logLevel -ge $MscLogWorstLevel ]; then
            MscLogWorstLevel=$logLevel
        fi
    fi
}

###
### msc_file_list_effective <file>
###    Prints lines whose first non-whitespace character is not '#'
###    In other words, this function skip empty, whitespace, or commented line
msc_file_list_effective() {
    sed -ne '/^[[:space:]]*[^#]/p' "$1"
}

###
### msc_apply <cmd> <file>
###   Apply a command to a key=value file.
###   For example, "msc_apply alias a_file" means
###   applying alias to each key=value lines in a_file.
msc_apply() {
    local cmd=$1
    local file=$2
    ## Remove the lines with leading '#' and empty lines
    ## Then eval the: <cmd> <key1>=<value1>; <cmd> <key2>=<value2>...

    eval $(msc_file_list_effective "$file" | sed -e "s/\([^=]*\)=/${cmd} \1=/" | tr "\n" ";")
}

###
### msc_help_print <cmd>
###     Print in-line help of a program
msc_help_print() {
    sed -rne '/^[[:space:]]*###/ s/^[[:space:]]*###( )?//p' "$1"
}

###
### msc_extract_section [-c contentPattern] [-e secEndRule] <secStartPattern>
###     Extract sections from stdin. If the secStartPattern occurs multiple
###     times, the contents are appended.
###
###     Argument:
###        secStartPattern:
###           An awk regex pattern without '//' that marks the start of section
###           e.g. Head[0-9]*
###
###     Options
###        -c contentRule:
###           An awk pattern that mark the content of section
###           Default: /^[[:blank:]]+[[:graph:]]/
###        -e secEndRule:
###           An awk pattern (rule) that mark the end of section
###           Default: !($contentRule) && !/$secStartPattern/
###
###     A file may contains following texts:
###
###         Head1
###            some text
###         Head2
###            some other text
###         Head3
###         ...
###
###      To parse Head2, use following
###         msc_extract_section Head2 Head3< file
msc_extract_section() {
    local OPTIND
    local secStartPattern
    local contentRule='/^[[:blank:]]+[[:graph:]]/'
    local secEndRule
    while getopts "c:e:" opt; do
        case $opt in
        c)
            contentRule="$OPTARG"
            ;;
        e)
            secEndRule="$OTARG"
            ;;
        esac
    done
    shift $((OPTIND - 1))
    secStartPattern="$1"
    secEndRule='!('"$contentRule"') && !/'"$secStartPattern"'/'

    awk -v 'start=0' 'start==1 && ('"$secEndRule"') {start=0}\
        start==1 && '"$contentRule"' {print}\
        /'"$secStartPattern"'/ {print; start=1}'
}

###
### msc_str_contains_substr <str> <substr>
###     Whether the string contains substring.
###     Returns: 0 if <str> contains <substr>; 1 otherwise
msc_str_contains_substr() {
    local str="$1"
    local substr="$2"
    if test "${str#*$substr}" != "$str"; then
        return 0
    fi
    return 1
}

### msc_is_interactive_mode
###     Whether the shell is in interactive mode.
###     Returns: 0 if in interactive mode; 1 otherwise
msc_is_interactive_mode() {
    msc_str_contains_substr "$-" i
    return $?
}

## Borrow from /etc/profile
msc_pathmunge() {
    case ":${PATH}:" in
    *:"$1":*) ;;

    *)
        if [ "$2" = "after" ]; then
            PATH=$PATH:$1
        else
            PATH=$1:$PATH
        fi
        ;;
    esac
}

###
### msc_quotes_strip
msc_quotes_strip() {
    local str="$1"
    str=${str#[\"]}
    echo "${str%[\"]}"
}

###
### msc_run_and_log <logLevel> <command> [args..]
msc_run_and_log() {
    local logLevel=$1
    shift
    msc_log "Run: $@" $logLevel
    $@
}

###
### msc_run_if_not_already [-u users] [-n processName] command [args...]
###   Run the command if it is not already be run
###   Options
###     -u <users>: Only matches the specified users.
###       Either UID or username works.
###     -n <processName>: processName is what shown in pgrep -l
###       Use this if process name is different with command
###       For example, google-chrome's process name is chrome
msc_run_if_not_already() {
    local processName
    local users
    local opts=""
    if [ "$1" = "-u" ]; then
        opts+="-u $2"
        shift 2
    fi
    # processName can only contains up 15 characters
    if [ "$1" = "-n" ]; then
        #
        processName="${2:0:15}"
        shift 2
    else
        processName="${1:0:15}"
    fi

    if ! pgrep $opts -lx $processName &>/dev/null; then
        if which "$1" >&/dev/null; then
            $@ &
        else
            msc_log "run_if_not_already: $1 not found, skip" warn
        fi
        msc_log "run_if_not_already run $processName: $*"
    else
        msc_log "already run $processName" warn
    fi
}
