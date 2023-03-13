
.PHONY: all 

all: bin functions

bin: msc-env-find

functions: msc-functions

%: %.bats
	bats/bin/bats $<