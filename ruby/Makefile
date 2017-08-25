all: test

build: .build

.build: Dockerfile docker/*.sh sandbox/script/*.sh sandbox
	docker build -t ruby-judge .
	touch .build

sandbox:
	$(MAKE) -C sandbox

test: build
	bats test/*/*.bats

clean:
	docker rm -v --force `docker ps -a| grep ruby-judge | awk '{print $$1}'` || true
	docker image rm --force ruby-judge || true
	rm -rf .build

clean-all: clean
	$(MAKE) -C sandbox clean

.PHONY: all build sandbox test clean clean-all
