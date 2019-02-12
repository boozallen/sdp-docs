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
LABSREPO      = https://github.com/boozallen/sdp-labs.git

.PHONY: help Makefile 

# Put it first so that "make" without argument is like "make help".
help: ## Show target options
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean: ## removes remote documentation and compiled documentation
	rm -rf $(BUILDDIR)  pages/libraries pages/jte pages/labs 

image: ## builds container image used to build documentation 
	docker build . -t sdp-docs

get-remote-docs: ## fetches sdp library and JTE documentation from their repos
	# library docs 
	ls pages/libraries || git clone --depth=1 -n --single-branch --branch=master $(LIBSREPO) pages/libraries
	cd pages/libraries && git checkout master -- $$(git diff --name-only --cached -- '*.rst') && cd -

	# jte docs
	ls pages/jte || git clone --depth=1 -n --single-branch --branch=master $(JTEREPO) pages/jte
	cd pages/jte && git checkout master -- docs && cd -

	# learning labs 
	ls pages/labs || git clone --depth=1 -n --single-branch --branch=master $(LABSREPO) pages/labs
	cd pages/labs && git checkout master -- $$(git diff --name-only --cached -- '*.rst' '**/docs/*' ) && cd -


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
		$(eval old_remote := $(shell git remote get-url origin)) \
		git remote set-url origin https://$(user):$(token)@github.com/boozallen/sdp-docs.git ;\
		docker run -v $(shell pwd):/app sdp-docs sphinx-versioning push --show-banner . gh-pages . ;\
		echo git remote set-url origin $(old_remote) ;\
		git remote set-url origin $(old_remote) ;\
	else\
		docker run -v $(shell pwd):/app sdp-docs $(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O);\
	fi

deploy: ;
live: ; 

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	echo "Make command $@ not found" 