# Minimal makefile to build Antora documentation
BUILDDIR = build
PLAYBOOK = antora-playbook.yml 

# Put it first so that "make" without argument is like "make help".
help: ## Show target options
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean: ## removes remote documentation and compiled documentation
	rm -rf $(BUILDDIR)/**

image: ## builds the Booz Allen antora image
	docker build resources -t antora/antora:boozallen

docs: clean image ## builds the antora documentation 
	docker run \
	-v ~/.git-credentials:/root/.git-credentials \
	-v $(shell pwd):/app \
	-v $(shell pwd)/resources/generator:/generator \
	-w /app \
	-e "DOCSEARCH_ENABLED=true" \
	-e "DOCSEARCH_ENGINE=lunr" \
	antora/antora:boozallen \
	antora generate --stacktrace \
	--generator  ../generator \
	--to-dir $(BUILDDIR) \
	--cache-dir .antora/cache \
	$(PLAYBOOK)