FILES=$(shell git ls-files | grep -v Makefile)
# Only list first level, otherwise cp -R will copy it as flat
TARGET_ITEMS=$(addprefix ${INSTALL_DIR}/, ${ITEMS})

debug:
	@echo "INSTALL_DIR=${INSTALL_DIR}"
	@echo "FILES=${FILES}"
	@echo "TARGET_ITEMS=${TARGET_ITEMS}"

diff:
	for f in ${FILES}; do echo "File: $$f"; diff {,${INSTALL_DIR}/}$$f; done

install:
	mkdir -p ${INSTALL_DIR}
	tar -c ${FILES} | tar --overwrite --no-same-owner -xv --directory ${INSTALL_DIR}

se-install: install
	restorecon -DRv ${INSTALL_DIR} 

update:
	for f in ${FILES}; do cp --update --preserve=timestamps -v ${INSTALL_DIR}/$$f $$f; done
