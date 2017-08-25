JUDGES=ruby
CLEAN_JUDGES=$(addprefix clean-, $(JUDGES))

all: $(JUDGES)

$(JUDGES):
	$(MAKE) -C $@

clean: $(CLEAN_JUDGES)

$(CLEAN_JUDGES): clean-% :
	$(MAKE) -C $* --ignore-errors clean-all

.PHONY: all $(JUDGES) $(CLEAN_JUDGES)
