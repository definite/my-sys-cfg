### Twolines prompt for bash that support VCS
### Usage: source from bash-internal.sh
###
### ENVIRONMENTS
###
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '(%s %r/%S)-[%b|%a]%m%u%c-'
zstyle ':vcs_info:*' formats '(%s %r/%S)-[%b]%m%u%c-'
zstyle ':vcs_info:*' enable git cvs svn hg
zstyle ':vcs_info:*' check-for-changes

precmd() {vcs_info}

__PS_COLOR_START=blue
__PS_COLOR_GIT=cyan
__PS_DIR_START=%~
if [ "$UID" = "0" ]; then
    __PS_COLOR_START=red
    __PS_COLOR_GIT=green
    __PS_DIR_START=%/
fi

PROMPT_LINE='%F{white}%B%K{'$__PS_COLOR_START'}%U## %* [%n@%m %l %L] '$__PS_DIR_START'%u %K{'$__PS_COLOR_GIT'}${vcs_info_msg_0_}%k%b%f
%B%h %#%b '
setopt prompt_subst
export PROMPT=$PROMPT_LINE

