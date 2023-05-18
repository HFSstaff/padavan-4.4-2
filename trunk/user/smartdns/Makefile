SRC_NAME = smartdns-Release40
THISDIR = $(shell pwd)

all: extract_test config_test
	$(MAKE) -C $(SRC_NAME)

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		tar -xf $(SRC_NAME).tar.gz ; \
	fi )

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		touch config_done; \
	fi )

clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) clean ; \
	fi ; \
	rm -f config_done

romfs:
	$(ROMFSINST) -p +x $(THISDIR)/$(SRC_NAME)/src/smartdns /usr/bin/smartdns
	$(ROMFSINST) -p +x $(THISDIR)/update-china-list.sh /usr/bin/update-china-list.sh
	$(ROMFSINST) /etc_ro/smartdns_custom.conf
	$(ROMFSINST) -p +x $(THISDIR)/kcptun /usr/bin/kcptun
	$(ROMFSINST) $(THISDIR)/kcptun_local.json /etc_ro/kcptun_local.json
