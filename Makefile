JUDGES=ruby
TEST_JUDGES=$(addprefix test-, $(JUDGES))
CLEAN_JUDGES=$(addprefix clean-, $(JUDGES))


all: $(JUDGES)

$(JUDGES):
	$(MAKE) -C $@

test: $(TEST_JUDGES)

$(TEST_JUDGES): test-% :
	$(MAKE) -C $* test-all

clean: $(CLEAN_JUDGES)

$(CLEAN_JUDGES): clean-% :
	$(MAKE) -C $* --ignore-errors clean-all

.PHONY: all $(JUDGES) test $(TEST_JUDGES) clean $(CLEAN_JUDGES)
