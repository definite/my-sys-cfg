#!/bin/bash
set -eu         # Exit when returns non-zero, Error when variable is unset.
### NAME
###     msc-install-sys-dir - Install files to system directory
###
### SYNOPSIS
###     msc-install-sys-dir [options]
###
### DESCRIPTION
###     Echo the profile of current system.
###     Profile is a combination of user defined system attributes.
###     like host name, docking status, names of connected networks and so on.
###     The attribute is defined in /etc/msc/profiles.tsv (tab separated patterns)
###
### AUTHOR
###     Ding-Yi Chen (definite), dchen@redhat.com
###     Created in 2020-01-29 
###
MSG_LOG_TAG=Install
MSC_LOG_PREFIX="[msc-install-sys-dir] "

ScriptDir=$(dirname $(realpath ${BASH_SOURCE[0]}))
if [ -r /etc/my-sys-cfg/local.sh ];then
    source /etc/my-sys-cfg/local.sh
else
    : ${MSC_LIBEXEC_DIR:=/usr/libexec/my-sys-cfg}
    export MSC_LIBEXEC_DIR
fi
source $MSC_LIBEXEC_DIR/functions.sh

##== Function Start ==
match_host(){
    local pattern="$1"
    if [[ $(hostname) != $pattern ]];then
        return 1
    fi
    return 0
}

match_neigh_mac(){
    local pattern="$1"
    for n in $(ip neigh show nud reachable|awk '{print $5}'); do
        if [[ $n == $pattern ]]; then
            return 0
        fi
    done
    return 1
}

match_usb(){
    local pattern="$1"
    if lsusb -d $pattern > /dev/null; then
        return 0
    fi
    return 1
}

match_net_name(){
    local pattern="$1"
    while read -r line; do
        if [[ $line == $pattern ]]; then
            return 0
        fi
    done < <(nmcli --terse --fields name con show --active)
    return 1
}

match_file_contain(){
    local pattern="$1"
    local option="$2"
    if [[ ! -e $pattern ]];then
        return 1
    fi
    if [[ ! $(cat "$pattern") = $option ]];then
        return 1
    fi
    return 0
}

match(){
    local tag="$1"
    local category="$2"
    local pattern="$3"
    local option="${4:-}"
    if eval "match_$(tr '[:upper:]' '[:lower:]'<<<$category) \"$pattern\" \"$option\"" ;then
        msc_log "tag $tag matched category $category pattern $pattern"
        Result+="$tag+"
    fi
}

##== Main Start ==
Result='+'

for feature_file in $MSC_ETC_MSC_DIR/features.d/*; do
    while read -r line ; do
        IFS=$'\t' read -r -a tokens <<<"$line"
        match "${tokens[@]}"
    done < <(msc_file_list_effective "$feature_file")
done
echo $Result

