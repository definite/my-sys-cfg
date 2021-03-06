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

# Targets that can be recursive
COMMON_TARGETS = debug diff install install-force se-install copy-to-source

CURR_MAKE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

help:
	@echo "Usages:"
	@echo "       make help: list targets"
	@sed -ne '/###/ s/###/      /p' ${CURR_MAKE_DIR}/targets.mk
