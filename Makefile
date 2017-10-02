DIRS=judge ruby python
PUSH_ALL=$(addprefix push-, $(DIRS))
TEST_ALL=$(addprefix test-, $(DIRS))
CLEAN_ALL=$(addprefix clean-, $(DIRS))

all: $(DIRS)

$(DIRS):
	$(MAKE) -C $@

push: $(PUSH_ALL)

$(PUSH_ALL): push-% :
	$(MAKE) -C $* push

test: $(TEST_ALL)

$(TEST_ALL): test-% :
	$(MAKE) -C $* test

clean: $(CLEAN_ALL)

$(CLEAN_ALL): clean-% :
	$(MAKE) -C $* clean

.PHONY: all build $(DIRS) push $(PUSH_ALL) test $(TEST_ALL) clean $(CLEAN_ALL)
