include common.mk

SUB_DIRS = bin etc libexec
.phony: help $(COMMON_TARGETS) $(SUB_DIRS)

help:
	@echo "Usage:"
	@echo "  sudo make install: Install it to system"
	@echo "  sudo make se-install: Install to system and set the SELinux labels"
	@echo "  sudo make uninstall: Uninstall from system"
	@echo "  make debug: Debug "
	@echo "  make diff: Diff between local and system"
	@echo "  make update: Copy files from system"

${COMMON_TARGETS}:
	for dir in ${SUB_DIRS}; do\
	  make -C $${dir} ${MAKECMDGOALS};\
	done

