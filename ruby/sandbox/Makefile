all: test

build: .build

.build: Dockerfile docker/*.sh
	docker build -t ruby-sandbox .
	touch .build

test: build
	bats test/*/*.bats

clean:
	docker rm -v --force `docker ps -a| grep ruby-sandbox | awk '{print $$1}'` || true
	docker image rm --force ruby-sandbox || true
	rm -rf .build

.PHONY: all build test clean
