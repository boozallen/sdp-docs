# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = SolutionsDeliveryPlatform
SOURCEDIR     = .
BUILDDIR      = _build
LIBSREPO      = https://github.com/boozallen/sdp-libraries.git
JTEREPO       = https://github.com/boozallen/jenkins-templating-engine.git

.PHONY: help Makefile

# Put it first so that "make" without argument is like "make help".
help: ## Show target options
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean: ## removes remote documentation and compiled documentation
	rm -rf $(BUILDDIR) pages/libraries pages/jte

image: ## builds container image used to build documentation 
	docker build . -t sdp-docs

get-remote-docs: ## fetches sdp library and JTE documentation from their repos
	# library docs 
	ls pages/libraries || git clone --depth=1 -n --single-branch --branch=master $(LIBSREPO) pages/libraries
	cd pages/libraries && git checkout master -- $$(git diff --name-only --cached -- '*.rst') && cd -

	# jte docs
	ls pages/jte || git clone --depth=1 -n --single-branch --branch=master $(JTEREPO) pages/jte
	cd pages/jte && git checkout master -- docs && cd -

# build docs 
docs: ## builds documentation in _build/html 
      ## run make docs live for hot reloading of edits during development
	make clean 
	make image
	make get-remote-docs

	@if [ "$(filter-out $@,$(MAKECMDGOALS))" = "live" ]; then\
		docker run -p 8000:8000 -v $(shell pwd):/app sdp-docs sphinx-autobuild -b html $(ALLSPHINXOPTS) . $(BUILDDIR)/html -H 0.0.0.0;\
	else\
		docker run -v $(shell pwd):/app sdp-docs $(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O);\
	fi

#push: 
#	make image 
#	make get-remote-docs
	# need to add sphinx-versioning command here when docs are ready to go public

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	echo "Make command $@ not found" 