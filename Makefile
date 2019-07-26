# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = SolutionsDeliveryPlatform
SOURCEDIR     = .
BUILDDIR      = docs
LABSREPO      = https://github.com/boozallen/sdp-labs.git
LIBSBRANCH    = master
JTEBRANCH     = master
LABSBRANCH    = master


.PHONY: help Makefile 

# Put it first so that "make" without argument is like "make help".
help: ## Show target options
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean: ## removes remote documentation and compiled documentation
	rm -rf pages/labs docs/doctrees docs/html 

image: ## builds container image used to build documentation 
	docker build . -t sdp-docs

get-remote-docs: ## fetches sdp library and JTE documentation from their repos
	# learning labs 
	ls pages/labs || git clone --depth=1 -n --single-branch --branch=$(LABSBRANCH) $(LABSREPO) pages/labs
	cd pages/labs && git checkout $(LABSBRANCH) -- $$(git diff --name-only --cached -- '*.rst' '**/docs/*' ) && cd -


# build docs 
docs: ## builds documentation in _build/html 
      ## run make docs live for hot reloading of edits during development
	make clean 
	make image
	#make get-remote-docs
	$(eval goal := $(filter-out $@,$(MAKECMDGOALS)))
	@if [ "$(goal)" = "live" ]; then\
		docker run -p 8000:8000 -v $(shell pwd):/app sdp-docs sphinx-autobuild -b html $(ALLSPHINXOPTS) . $(BUILDDIR)/html -H 0.0.0.0;\
	elif [ "$(goal)" = "deploy" ]; then\
		docker run -v $(shell pwd):/app sdp-docs $(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O);\
		git add docs/*
		git commit -m "updating documentation"
		git push
	else\
		
	fi

deploy: ;

live: ; 

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	echo "Make command $@ not found" 