# Minimal makefile to build Antora documentation
BUILDDIR = docs
PLAYBOOK = antora-playbook.yml 

# Put it first so that "make" without argument is like "make help".
help: ## Show target options
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean: ## removes remote documentation and compiled documentation
	rm -rf $(BUILDDIR)/**

.ONESHELL:
install:  ## installs the project's npm dependencies
	[ ! -d node_modules ] && npm i || true

docs: clean install ## builds the antora documentation 
	$(shell npm bin)/antora generate --fetch --generator ./site-generator --to-dir $(BUILDDIR) $(PLAYBOOK)

preview: clean install ## runs a local preview server to view changes to the documentation
	$(shell npm bin)/gulp preview 