### Twolines prompt for bash that support VCS
### Usage: source from bash-internal.sh
###
### ENVIRONMENTS
###

##== Main Start ==
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_DESCRIBE_STYLE="describe"

source /usr/libexec/my-sys-cfg/git-prompt.sh
case $0 in
    bash|sh|zsh )
        export -f __git_ps1
        ;;
    * )
        export __git_ps1
        ;;
esac

if [ -t 1 ]; then
    ## In a tty
    __COLOR=1
else
    ## Not in a tty
    __COLOR=0
fi

__PS_COLOR_START=
__PS_COLOR_GIT=
__PS_COLOR_PROMPT_LINE=
__PS_COLOR_END=
if [ $__COLOR -eq 1 ];then
    if [ $UID -eq 0 ];then
        __PS_COLOR_START='\[\e[4;97m\]\[\e[4;41m\]'
        __PS_COLOR_GIT='\[\e[4;42m\]'
        __PS_COLOR_PROMPT_LINE='\[\e[1;37m\]'
    else
        __PS_COLOR_START='\[\e[4;97m\]\[\e[4;44m\]'
        __PS_COLOR_GIT='\[\e[4;45m\]'
        __PS_COLOR_PROMPT_LINE='\[\e[1;37m\]'
    fi
    __PS_COLOR_END='\[\e[0m\]'
fi

__PS_LINE1="${__PS_COLOR_START}## \t [\u@\h \l ${SHLVL}] \w${__PS_COLOR_GIT}"'$(__git_ps1 " %s")'"${__PS_COLOR_END}"
__PS_LINE2="${__PS_COLOR_PROMPT_LINE}\! "'\$'"${__PS_COLOR_END} "
export PS1="${__PS_LINE1}\n${__PS_LINE2}"

