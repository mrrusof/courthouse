all: test

compile:
	cd src && docker build -t ruby-judge .

test: compile
	@export JUDGE_TIMEOUT=0.5 && \
	for f in $$(pwd)/test/*; do \
	  ./run-test.sh $$f $$(pwd)/run-ruby-judge.sh; \
        done

clean:
	docker container prune --force
	docker image rm --force ruby-judge

.PHONY: all compile test clean
