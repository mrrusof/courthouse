JUDGE=ruby
IMAGE=$(JUDGE)-judge
REPO=mrrusof/$(IMAGE)
TAG=latest

all: build

build: .build

.build: Dockerfile docker/*.sh sandbox/script/*.sh sandbox
	docker build -t $(REPO) .
	touch .build

sandbox:
	$(MAKE) -C sandbox build

push: build
	docker push $(REPO):$(TAG)

test: build
	bats test/*/*.bats

clean:
	docker rm -v --force `docker ps -a | grep $(IMAGE) | awk '{print $$1}'` || true
	docker image rm --force $(REPO) || true
	rm -rf .build

%-all:
	$(MAKE) -C sandbox $*
	$(MAKE) $*

.PHONY: all build sandbox push test clean %-all
