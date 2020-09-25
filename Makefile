# Minimal makefile to build Antora documentation
BUILDDIR = docs
PLAYBOOK = antora-playbook.yml 
LOCAL_PLAYBOOK = antora-playbook-local.yml 
ANTORABUNDLE = 

# Put it first so that "make" without argument is like "make help".
help: ## Show target options
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

clean: ## removes remote documentation and compiled documentation
	rm -rf $(BUILDDIR)/**

imagePush: 
	@echo "Building Antora Image" 
	@docker build . -t docker.pkg.github.com/boozallen/sdp-docs/builder
	@docker push docker.pkg.github.com/boozallen/sdp-docs/builder

local-preview: clean ## builds the antora documentation 	
	@docker run -v ~/.git-credentials:/root/.git-credentials -v $(shell pwd):/antora:Z --rm -t docker.pkg.github.com/boozallen/sdp-docs/builder generate --stacktrace --generator booz-allen-site-generator --to-dir $(BUILDDIR) $(ANTORABUNDLE) antora-playbook-local-only.yml
preview: clean ## builds the antora documentation 	
	@docker run -v ~/.git-credentials:/root/.git-credentials -v $(shell pwd):/antora:Z --rm -t docker.pkg.github.com/boozallen/sdp-docs/builder generate --stacktrace --generator booz-allen-site-generator --to-dir $(BUILDDIR) $(ANTORABUNDLE) $(LOCAL_PLAYBOOK)
docs: clean ## builds the antora documentation 	
	@docker run -v ~/.git-credentials:/root/.git-credentials -v $(shell pwd):/antora:Z --rm -t docker.pkg.github.com/boozallen/sdp-docs/builder generate --stacktrace --generator booz-allen-site-generator --to-dir $(BUILDDIR) $(ANTORABUNDLE) $(PLAYBOOK)
