JUDGES=ruby
PUSH_JUDGES=$(addprefix push-, $(JUDGES))
TEST_JUDGES=$(addprefix test-, $(JUDGES))
CLEAN_JUDGES=$(addprefix clean-, $(JUDGES))


all: $(JUDGES)

$(JUDGES):
	$(MAKE) -C $@

push: $(PUSH_JUDGES)

$(PUSH_JUDGES): push-% :
	$(MAKE) -C $* push-all

test: $(TEST_JUDGES)

$(TEST_JUDGES): test-% :
	$(MAKE) -C $* test-all

clean: $(CLEAN_JUDGES)

$(CLEAN_JUDGES): clean-% :
	$(MAKE) -C $* --ignore-errors clean-all

.PHONY: all $(JUDGES) push $(PUSH_JUDGES) test $(TEST_JUDGES) clean $(CLEAN_JUDGES)
