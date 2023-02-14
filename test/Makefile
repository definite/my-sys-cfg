
.PHONY: all 

all: bin

bin: msc-env-find

%: %.bats
	bats/bin/bats $<