all: test

build:
	cd src && docker build -t ruby-judge .

test: build
	@for f in $$(pwd)/test/*; do \
	  ./test.sh $$f $$(pwd)/ruby-judge.sh; \
        done

clean:
	docker container prune --force
	docker image rm --force ruby-judge

.PHONY: all compile test clean
