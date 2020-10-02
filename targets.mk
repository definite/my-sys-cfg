# Contain common targets and helper functions
INST_OWNER ?= root
INST_GROUP ?= root
# MODE=0 means unchnaged
FILE_MODE ?= 0
DIR_MODE ?= 0
FILES=$(shell git ls-files | grep -v Makefile)
TARGET_FILES=$(addprefix ${INSTALL_DIR}/, ${FILES})
curr_makefile := $(lastword $(makefile_list))

ifneq ($(FILE_MODE),0)
INSTALL_MODE_OPT = -m $(FILE_MODE)
endif

${INSTALL_DIR}/%: %
	mkdir -p $(dir ${INSTALL_DIR}/$*)
ifneq ($(DIR_MODE),0)
	chmod --changes ${DIR_MODE} $(dir ${INSTALL_DIR}/$*)
endif
	chown --changes ${INST_OWNER}:${INST_GROUP} $(dir ${INSTALL_DIR}/$*)
	install -t $(dir ${INSTALL_DIR}/$*) -o ${INST_OWNER} -g ${INST_GROUP} $(INSTALL_MODE_OPT) $*

### sudo make install: install to INSTALL_DIR, without override the newer file
install: ${TARGET_FILES}

### sudo make install-force: install to INSTALL_DIR, and overwrite the target files.
install-force:
	mkdir -p ${INSTALL_DIR}
	tar -c ${FILES} | tar --overwrite -xv --directory ${INSTALL_DIR}
	cd ${INSTALL_DIR} && for f in ${FILES};do\
		if [ ${FILE_MODE} -gt 0 ];then\
		   chmod --changes ${FILE_MODE} "$$f";\
		fi;\
		chown --changes ${INST_OWNER}:${INST_GROUP} "$$f";\
		done

### sudo make se-install: install and set the SELinux labels
se-install: ${TARGET_FILES}
	## RHEL 7 and earlier does not support restorecon -D
	if restorecon -h |& grep '\-[^ ]*D' > /dev/null; then\
		restorecon -DRv ${INSTALL_DIR};\
	else\
		restorecon -Rv ${INSTALL_DIR};\
	fi

### make debug: Show the variable values
debug:
	@echo "INSTALL_DIR=${INSTALL_DIR}"
	@echo "FILES=${FILES}"
	@echo "TARGET_FILES=${TARGET_FILES}"

### make diff: Show the diff between source and target
diff:
	for f in ${FILES}; do echo "File: $$f"; diff {,${INSTALL_DIR}/}$$f; done

### make copy-to-source: Copy the target files back to source.
###	 Useful when testing new setting with target files directly.
copy-to-source:
	for f in ${FILES}; do cp --update --preserve=timestamps -v ${INSTALL_DIR}/$$f $$f; done

