all: test

build: sandbox.tar

sandbox.tar: Dockerfile docker/*
	docker build -t ruby-sandbox .
	docker save --output sandbox.tar ruby-sandbox

test: build
	bats test/*/*.bats

clean:
	docker rm -v --force `docker ps -a| grep ruby-sandbox | awk '{print $1}'` || true
	docker image rm --force ruby-sandbox || true
	rm -rf sandbox.tar

.PHONY: all build test clean
