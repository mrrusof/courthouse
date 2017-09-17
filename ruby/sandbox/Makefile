JUDGE=ruby
IMAGE=$(JUDGE)-sandbox
REPO=mrrusof/$(IMAGE)
TAG=latest

all: build

build: .build

.build: Dockerfile docker/*.sh
	docker build -t $(REPO) .
	touch .build

push: build
	docker push $(REPO):$(TAG)

test: build
	bats test/*/*.bats

clean:
	docker rm -v --force `docker ps -a | grep $(IMAGE) | awk '{print $$1}'` || true
	docker image rm --force $(REPO) || true
	rm -rf .build

.PHONY: all build push test clean
