# Name of this project
NAME := my-sys-cfg

# Place to install system wide configuration
ETC_PREFIX ?= /etc

# Location of files to be installed 
PREFIX ?= /usr/local

# Executable to be called by other executables, not from the end users.
LIBEXEC_PREFIX ?= /usr/libexec

# Internal executables for this project
PRJ_LIBEXEC_PREFIX ?= ${LIBEXEC_PREFIX}/${NAME}

# Common targets
COMMON_TARGETS = debug diff install se-install uninstall update

