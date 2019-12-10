# Contain common targets and helper functions
INST_OWNER ?= root
INST_GROUP ?= root
FILE_MODE ?= 644
DIR_MODE ?= 755
FILES=$(shell git ls-files | grep -v Makefile)
TARGET_FILES=$(addprefix ${INSTALL_DIR}/, ${FILES})
curr_makefile := $(lastword $(makefile_list))

${INSTALL_DIR}/%: %
	mkdir -p $(dir ${INSTALL_DIR}/$*)
	chmod --changes ${DIR_MODE} $(dir ${INSTALL_DIR}/$*)
	chown --changes ${INST_OWNER}:${INST_GROUP} $(dir ${INSTALL_DIR}/$*)
	install -t $(dir ${INSTALL_DIR}/$*) -o ${INST_OWNER} -g ${INST_GROUP} -m ${FILE_MODE} $*

### sudo make install: install to INSTALL_DIR, without override the newer file
install: ${TARGET_FILES}

### sudo make install-force: install to INSTALL_DIR, and overwrite the target files.
install-force:  
	mkdir -p ${INSTALL_DIR}
	tar -c ${FILES} | tar --overwrite -xv --directory ${INSTALL_DIR}
	cd ${INSTALL_DIR} && for f in ${FILES};do\
		chmod --changes ${FILE_MODE} "$$f";\
		chown --changes ${INST_OWNER}:${INST_GROUP} "$$f";\
		done

### sudo make se-install: install and set the SELinux labels
se-install: ${TARGET_FILES}
	restorecon -DRv ${INSTALL_DIR} 

### make debug: Show the variable values
debug:
	@echo "INSTALL_DIR=${INSTALL_DIR}"
	@echo "FILES=${FILES}"
	@echo "TARGET_FILES=${TARGET_FILES}"

### make diff: Show the diff between source and target
diff:
	for f in ${FILES}; do echo "File: $$f"; diff {,${INSTALL_DIR}/}$$f; done

### make copy-to-source: Copy the target files back to source. 
###     Useful when testing new setting with target files directly.
copy-to-source:
	for f in ${FILES}; do cp --update --preserve=timestamps -v ${INSTALL_DIR}/$$f $$f; done

