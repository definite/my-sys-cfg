include libexec/common.mk

SUB_DIRS = bin etc libexec
.PHONY: help test $(COMMON_TARGETS) $(SUB_DIRS)

${COMMON_TARGETS}:
	for dir in ${SUB_DIRS}; do\
	  make -C $${dir} ${MAKECMDGOALS};\
	done

test:
	make -C test all
