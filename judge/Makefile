SHELL=/bin/bash

IMAGE=judge
REPO=mrrusof/$(IMAGE)
TAG=latest

BUILD_DIR=build

DOCKER_SDIR=docker
DOCKER_BDIR=$(BUILD_DIR)/docker
DOCKERFILE=$(DOCKER_BDIR)/Dockerfile
DOCKER_BTOKEN=$(DOCKER_BDIR)/docker.done

BDIRS=$(DOCKER_BDIR)

all build: $(BDIRS) $(DOCKER_BTOKEN)

$(DOCKER_BTOKEN): $(DOCKERFILE) $(addprefix $(DOCKER_BDIR)/, judge.sh run-sandbox.sh remove-sandbox.sh)
	docker build -t $(REPO) $(DOCKER_BDIR)
	touch $@

$(DOCKER_BDIR)/% : $(DOCKER_SDIR)/%
	cp -a $< $@

$(BDIRS):
	mkdir -p $@

push: build
	docker push $(REPO):$(TAG)

test:
	@echo Nothing to test here.

clean:
	docker rm -v --force `docker ps -a | grep $(IMAGE) | awk '{print $$1}'` || true
	docker image rm --force $(REPO) || true
	rm -rf $(BUILD_DIR)

%-all:
	$(MAKE) -C sandbox $*
	$(MAKE) $*

.PHONY: all build push test clean
