## bash and zsh shared starup script
##
## For RHEL and Fedora, the scripts in /etc/profile.d will be called by:
##   bash or zsh: login shell and interactive non-login shell
##
: ${MSC_LIBEXEC_DIR:=/usr/libexec/my-sys-cfg}
export MSC_LIBEXEC_DIR
source $MSC_LIBEXEC_DIR/functions.sh

MY_PATH=(/rescue /sbin /usr/sbin /usr/local/bin /usr/local/sbin /usr/libexec/git-core $HOME/bin)
for p in "${MY_PATH[@]}";do
    msc_pathmunge "$p" after
done
unset MY_PATH


## Erase the duplicate lines in the history
export HISTCONTROL=erasedups


msc_apply export /etc/my-sys-cfg/env_value
if msc_is_interactive_mode ;then
    msc_apply alias /etc/my-sys-cfg/alias_value
    ## Set up prompt
    if [ ! "${ZSH_NAME:-}" = "zsh" ];then
        ## Set bash prompt
        ## zsh prompt is set at msc-zsh.sh
        source $MSC_LIBEXEC_DIR/bash-prompt.sh
    fi
fi
