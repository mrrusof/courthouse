SHELL=/bin/bash

all build:
	@echo Nothing to build here.

push:
	@echo Nothing to push here.

test:
	$(MAKE) -C ../sandbox build
	$(MAKE) -C $(ROOT)/judge build
	JUDGE=$(JUDGE) bats test/*/*.bats

clean:
	@echo Nothing to clean here.

.PHONY: all build push test clean
