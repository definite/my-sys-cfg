### source this script for common functions and environment variables

: ${MSC_LIBEXEC_DIR:=/usr/libexec/my-sys-cfg}
export MSC_LIBEXEC_DIR

source $MSC_LIBEXEC_DIR/const.sh

: ${MSC_LOG_FACILITY:=user}
: ${MSC_LOG_LEVEL:=notice}
: ${MSC_LOG_PREFIX:=}

###
### MSG_LOG_OPTIONS
###     Options for logger. Default is '-s', i.e. also print error message to
###     stderr.
###     Default: -s
: ${MSC_LOG_OPTIONS:="-s"}
###
### MSC_LOG_TAG
###     Marked the log with a specified tag.
###     Default: my-sys-cfg
: ${MSC_LOG_TAG:=my-sys-cfg}

##
## MscLogWorstStatusCode
##     Worst (Biggest) status code encountered
##     This is mainly for the log level 'error', which means the eventually
##     the program will fail, but no need to exit immediately.
MscLogWorstStatusCode=$MSC_EXIT_OK
MscExitMsg=

###
### msc_array_get_value <array> <index>
###     Return value of an array
###     This function address the difference between
###     how bash and zsh handles associative array
msc_array_get_value() {
    if [ -n "${ZSH_NAME-}" ]; then
        ## Use Parameter Expension P flag from ZSH
        echo ${${(P)1}[$2]}
    else
        ## Need quote for associative array in bash
        eval 'echo ${'$1"['"$2"']}"
    fi
}

###
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
    local logLevel
    local finalMsg="$MSC_LOG_PREFIX"

    ## Detemine log level
    if [ -n "${1:-}" ]; then
        logLevel=$1
        shift
    else
        logLevel=$MSC_LOG_LEVEL
    fi

    ## Omit the lower priority
    if [ $(msc_array_get_value MSC_LOG_LEVEL_DICT $logLevel) -lt $(msc_array_get_value MSC_LOG_LEVEL_DICT $MSC_LOG_LEVEL) ]; then
        return
    fi

    case $logLevel in
    emerg)
        finalMsg+="[EMERG] $msg"
        ;;
    alert)
        finalMsg+="[ALERT] $msg"
        ;;
    crit)
        finalMsg+="[CRIT] $msg"
        ;;
    err)
        finalMsg+="[ERR] $msg"
        ;;
    warning)
        finalMsg+="[Warning] $msg"
        ;;
    notice)
        finalMsg+="[notice] $msg"
        ;;
    *)
        finalMsg+="$msg"
        ;;
    esac
    logger $MSC_LOG_OPTIONS ${MSC_LOG_TAG:+-t $MSC_LOG_TAG} -p "$MSC_LOG_FACILITY.$logLevel" "$@" "$finalMsg"
}

###
### msc_exit_status_to_log_level <exitStatus>
msc_exit_status_to_log_level() {
    local exitStatus=$1
    local logLevel
    if [ $exitStatus -eq $MSC_EXIT_OK ]; then
        echo info
    elif [ $exitStatus -le $MSC_EXIT_RETURN ]; then
        echo $MSC_LOG_LEVEL
    elif [ $exitStatus -le $MSC_EXIT_WARNING ]; then
        echo warning
    elif [ $exitStatus -le $MSC_EXIT_ERR ]; then
        echo err
    elif [ $exitStatus -le $MSC_EXIT_CRIT ]; then
        echo crit
    else
        echo alert
    fi
}

###
### msc_exit_print_error
###   print error when program exit
###   Insert "trap msc_exit_print_error EXIT" to activate the function
msc_exit_print_error() {
    local exitStatus=${?:-$MscLogWorstStatusCode}
    if [ -n "${MscExitMessageDict[$exitStatus]}" ]; then
        msc_log "$MscExitMsg" $(msc_exit_status_to_log_level $exitStatus)
    else
        msc_log "Undefined Exit Code $exitStatus Error: $MscExitMsg" alert
    fi
    exit $exitStatus
}

###
### msc_fail <msg> <exitStatus>
###     Indicate something is wrong.
###     Exit program if logLevel is equal or larger than MSC_LOG_LEVEL_DICT['crit']
msc_fail() {
    local msg="$1"
    local exitStatus=$2
    if [ $exitStatus -ge $MscLogWorstStatusCode ]; then
        MscLogWorstStatusCode=$exitStatus
    fi
    if [[ $exitStatus -gt ${MSC_LOG_LEVEL_DICT['err']} ]]; then
        ## Crit
        MscExitMsg="$1"
        ## Should be handle by msc_exit_print_error
        exit $exitStatus
    else
        ## Not yet exit
        msc_log "$msg" $(msc_exit_status_to_log_level $exitStatus)

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
    msc_log "Run: $*" $logLevel
    $@
}

###
### msc_run_if_not_already [Options] [ command args...]
###   Run the command if it is not already be run
###   Options
###     -a <sshArg>: SSH Arguments
###       Specify the arguments required to run SSH
###       e.g.  -X hostname DISPLAY=:0
###     -c <command>: Specify command
###       Use this option when command is not the first none option argument.
###     -u <users>: Only matches the specified users.
###       Either UID or username works.
###     -n <processName>: processName is what shown in pgrep -l
###       Use this if process name is different with command
###       For example, google-chrome's process name is chrome
msc_run_if_not_already() {
    local processName
    local cmd
    local sshCmd
    local sshDebugMsg=""
    local pgrepOptArray=()
    local opt
    local OPTIND

    while getopts "a:c:n:u:" opt; do
        case $opt in
        a)
            sshCmd="ssh $OPTARG"
            sshDebugMsg=" with SSH arg $OPTARG"
            ;;
        c)
            cmd="$OPTARG"
            ;;
        n)
            processName="${2:0:15}"
            ;;
        u)
            user="$OPTARG"
            pgrepOptArray+=(-u "$2")
            ;;
        esac
    done
    shift $((OPTIND - 1))

    if [ -z "$cmd" ]; then
        cmd="$1"
    fi

    if [ -z "$processName" ]; then
        processName="${cmd:0:15}"
    fi

    if eval "$sshCmd pgrep ${pgrepOptArray[@]} -lx $processName" &>/dev/null; then
        msc_log "already run $processName$sshDebugMsg" notice
    else
        if eval "$sshCmd which $cmd" >&/dev/null; then
            msc_log "run_if_not_already run $processName: ${sshCmd[*]} $*" info
            eval "$sshCmd $@" &
        else
            msc_log "run_if_not_already: skip the missing command $cmd$sshDebugMsg" warning
        fi
    fi
}
