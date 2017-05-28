JUDGES=ruby
CLEAN_JUDGES=$(addprefix clean-, $(JUDGES))

all: $(JUDGES)

$(JUDGES):
	cd $@ && $(MAKE)

clean: $(CLEAN_JUDGES)

$(CLEAN_JUDGES): clean-% :
	cd $* && $(MAKE) --ignore-errors clean

.PHONY: all $(JUDGES) $(CLEAN_JUDGES)
