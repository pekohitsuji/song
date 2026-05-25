SHELL   := /bin/bash
RM      := rm -f

PYTHON  := python3
SCHEME  := gosh

GIT_URL := https://github.com/pekohitsuji/$(shell basename $$(pwd)).git
GIT_CHK := git config remote.origin.url
GIT_ADD := git remote add origin $(GIT_URL)

HARVEST := README.md tool/identify_ai.md

all : $(HARVEST)

clean :
	$(RM) $(HARVEST)
	find -name "*~" -delete

var :
	@echo ECHO: $(GIT_ADD)

git :
	if [ ! -d .git ] ; then git init ; fi
	if [ $(HOME) != /home/mogeba ] ; then \
	    echo Never: make git ; \
	    exit 1 ; \
	fi
	git config --local user.name  pekohitsuji
	git config --local user.email kaeru0921@icloud.com
	if [ -z "$$($(GIT_CHK))" ] ; then $(GIT_ADD) ; fi
	git add .
	git commit -m "first commit"
	git branch -M main
	git push -u origin main

tags : TAGS
	ctags -R -e

README.md : README.sh Makefile *.html
	@echo Updated: $?
	ls -- *.html | sed '/---temp\.html/d' | xargs -d '\n' ./README.sh

tool/identify_ai.md : tool/identify_ai.py Makefile
	@echo Updated: $?
	$(PYTHON) $< > $@
