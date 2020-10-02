## Invoked by either interactive and login shell
## Note that for interactive login shell, this file will only be invoke
## from /etc/zprofile -> /etc/profile -> /etc/profile.d/*.sh
## But not from /etc/zshrc ->  /etc/profile.d/*.sh
## Seems like zsh prevents same scripts from loading multiple time.
## This cause some setting and env being restored by /etc/zshrc
## such as PS1.

if [ "${ZSH_NAME:-}" = "zsh" ]; then
    : ${MSC_LIBEXEC_DIR:=/usr/libexec/my-sys-cfg}
    export MSC_LIBEXEC_DIR
    source $MSC_LIBEXEC_DIR/functions.sh
    MSC_LOG_TAG=UserStartup
    MSC_LOG_PREFIX="[msc-zsh.sh] "
    msc_log "SHLVL=$SHLVL DESKTOP_SESSION=$DESKTOP_SESSION" debug

    if [ "${-#*i}" != "$-" ]; then
        ## Interactive Shell
        msc_log "Interactive mode" debug

        cdpath=(.. $HOME $HOME/cases)

        #allow tab completion in the middle of a word
        setopt COMPLETE_IN_WORD

        ## keep background processes at full speed
        #setopt NOBGNICE
        ## restart running processes on exit
        #setopt HUP

        ## History
        ##   Uncomment for sessions to append their history list to the history file instead of replacing it
        #setopt APPEND_HISTORY

        ##   Uncomment for sessions to append their history as soon as they
        ## are entered, otherwise same with APPEND_HISTORY
        #setopt INC_APPEND_HISTORY
        #setopt SHARE_HISTORY

        ## never ever beep ever
        #setopt NO_BEEP

        ## automatically decide when to page a list of completions
        #LISTMAX=0

        ## disable mail checking
        #MAILCHECK=0
        #    zstyle ':completion:*' accept-exact '*(N)'
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path $HOME/.zsh/cache

        autoload -Uz colors && colors

        # No need to set PROMPT and related here, /etc/bashrc will override it anyway
        source $MSC_LIBEXEC_DIR/zsh-prompt.sh
    fi
fi
