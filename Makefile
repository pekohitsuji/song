SHELL   := /bin/bash
RM      := rm -f

GIT_URL = https://github.com/pekohitsuji/$(shell basename $$(pwd)).git
GIT_CHK = git config remote.origin.url
GIT_ADD = git remote add origin $(GIT_URL)

all : README.md

clean :
	$(RM) README.md
	find -name "*~" -delete

git :
	if [ ! -d .git ] ; then git init ; fi
	git config --local user.name  pekohitsuji
	git config --local user.email kaeru0921@icloud.com
	if [ -z "$$($(GIT_CHK))" ] ; then $(GIT_ADD) ; fi
	@echo "Do folloings:"
	@echo "    git add ."
	@echo "    git commit -m \"first commit\""
	@echo "    git branch -M main"
	@echo "    git push -u origin main"

tags : TAGS
	ctags -R -e

README.md : README.sh
	ls -- *.html | sed '/---temp\.html/d' | xargs -d '\n' ./README.sh
