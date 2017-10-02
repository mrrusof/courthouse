SHELL=/bin/bash

IMAGE=$(JUDGE)-sandbox
REPO=mrrusof/$(IMAGE)
TAG=latest

INCL_DIR=$(ROOT)/common/sandbox
BUILD_DIR=build

DOCKER_SDIR=docker
DOCKER_BDIR=$(BUILD_DIR)/docker
DOCKERFILE=$(DOCKER_BDIR)/Dockerfile
DOCKERFILE_IN=$(DOCKER_SDIR)/Dockerfile.in
DOCKER_BTOKEN=$(BUILD_DIR)/docker.done

BDIRS=$(DOCKER_BDIR)

all build: $(BDIRS) $(DOCKER_BTOKEN)

$(DOCKER_BTOKEN): $(DOCKERFILE) $(DOCKER_BDIR)/sandbox.sh
	docker build -t $(REPO) $(DOCKER_BDIR)
	touch $@

$(DOCKERFILE): $(DOCKERFILE_IN) $(INCL_DIR)/docker/sandbox.docker
	cpp -o $@ $<

$(BDIRS):
	mkdir -p $@

$(BUILD_DIR)/% : $(INCL_DIR)/%
	cp -va $< $@

push: build
	docker push $(REPO):$(TAG)

test: build
	JUDGE=$(JUDGE) bats test/*/*.bats

clean:
	docker rm -v --force `docker ps -a | grep $(IMAGE) | awk '{print $$1}'` || true
	docker image rm --force $(REPO) || true
	rm -rf $(BUILD_DIR)

.PHONY: all build push test clean
