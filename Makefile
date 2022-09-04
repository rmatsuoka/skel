PREFIX= $(HOME)

TARGET= \
	.clang-format \
	.exrc \
	.screenrc \
	.vimrc 

all:
	@echo run make install

install: $(TARGET)
	for i in $(TARGET); \
	do \
		ln -sf $(PWD)/$$i $(PREFIX)/$$i; \
	done
