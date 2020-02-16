# Minimal makefile to build Antora documentation
BUILDDIR = build
PLAYBOOK = antora-playbook.yml 

# Put it first so that "make" without argument is like "make help".
help: ## Show target options
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean: ## removes remote documentation and compiled documentation
	rm -rf $(BUILDDIR)/**

.ONESHELL:
docs: clean ## builds the antora documentation 
	[ ! -d node_modules ] && npm i || true
	$(shell npm bin)/antora generate --fetch --generator ./site-generator --to-dir docs $(PLAYBOOK)

preview:
	$(shell npm bin)/gulp preview 