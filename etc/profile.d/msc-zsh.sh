## Invoked by either interactive and login shell
## Note that for interactive login shell, this file will only be invoke
## from /etc/zprofile -> /etc/profile -> /etc/profile.d/*.sh
## But not from /etc/zshrc ->  /etc/profile.d/*.sh
## Seems like zsh prevents same scripts from loading multiple time.
## This cause some setting and env being restored by /etc/zshrc
## such as PS1.

if [ "${ZSH_NAME:-}" = "zsh" ]; then
  : ${MSC_LIBEXEC_DIR:=/usr/libexec/my-sys-cfg}
  source $MSC_LIBEXEC_DIR/functions.sh
  MSC_LOG_TAG=UserStartup
  MSC_LOG_PREFIX="[msc-zsh.sh] "
  msc_log "SHLVL=$SHLVL DESKTOP_SESSION=$DESKTOP_SESSION" debug

  if [ "${-#*i}" != "$-" ]; then
    ## Interactive Shell
    msc_log "Interactive mode" debug

    [ -r $MSC_ETC_MSC_DIR/shells.d/zsh-interactive.sh ] &&\
    source $MSC_ETC_MSC_DIR/shells.d/zsh-interactive.sh
  fi
fi
