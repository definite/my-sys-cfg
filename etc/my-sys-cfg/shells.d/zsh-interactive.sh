### ZSH interactive setting
 
## allow tab completion in the middle of a word
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
# Comment the following line if you don't want twolines prompt
source $MSC_LIBEXEC_DIR/zsh-prompt-twolines.sh
