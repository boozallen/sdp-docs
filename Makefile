# Minimal makefile to build Antora documentation
BUILDDIR = docs
PLAYBOOK = antora-playbook.yml 
ANTORABUNDLE = 

# Put it first so that "make" without argument is like "make help".
help: ## Show target options
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean: ## removes remote documentation and compiled documentation
	rm -rf $(BUILDDIR)/**

image: 
	@echo "Building Antora Image" 
	@docker build . -t sdp-antora

docs: clean image ## builds the antora documentation 	
	@docker run -v ~/.git-credentials:/root/.git-credentials -v $(shell pwd):/antora:Z --rm -t sdp-antora generate --stacktrace --generator ./site-generator --to-dir $(BUILDDIR) $(ANTORABUNDLE) $(PLAYBOOK)