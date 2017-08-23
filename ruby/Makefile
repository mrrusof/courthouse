all: test

build: .build

.build: Dockerfile docker/*.sh sandbox/script/*.sh sandbox/sandbox.tar
	$(MAKE) clean-containers
	docker build -t pre-ruby-judge .
	docker run --privileged --volume `pwd`/sandbox:/sandbox:ro --name pre-ruby-judge pre-ruby-judge /judge/load-sandbox.sh
	docker commit --change 'CMD /judge/judge.sh' pre-ruby-judge ruby-judge
	touch .build

sandbox/sandbox.tar:
	$(MAKE) -C sandbox

test: build
	bats test/*/*.bats

clean:
	$(MAKE) -C sandbox clean
	$(MAKE) clean-containers
	docker image rm --force pre-ruby-judge || true
	docker image rm --force ruby-judge || true
	rm -rf .build

clean-containers:
	docker rm -v --force `docker ps -a| grep ruby-judge | awk '{print $$1}'` || true

.PHONY: all build test clean clean-containers
