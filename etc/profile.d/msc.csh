if ($?prompt) then
  if ($?tcsh) then
    set promptchars='>#'
    set prompt="%B%n@%m: %~ %! %# "
  endif
endif
set path = ($path /rescue /sbin /usr/sbin /usr/local/bin /usr/local/sbin  /usr/libexec/git-core $HOME/bin )

#simplified env/alias setting
alias env_setting 'eval `grep -hv "^[[:space:]]*#" \!^ | grep -hv "^[[:space:]]*"$ |sed -e "s/\([^=]*\)=/setenv \1 /" | tr "\n" ";"`'
alias alias_setting 'eval `grep -hv "^[[:space:]]*#" \!^ | grep -hv "^[[:space:]]*"$ |sed -e "s/\([^=]*\)=/alias \1 /" | tr "\n" ";"`'

env_setting /etc/local/env_value
alias_setting /etc/local/alias_value

set autolist ambiguous

