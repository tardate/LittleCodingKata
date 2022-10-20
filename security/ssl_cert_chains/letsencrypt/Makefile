# https://letsencrypt.org/certificates/

TARGETS := lets-encrypt-r3.der isrgrootx1.der lets-encrypt-r3.der.printcert lets-encrypt-r3.der.signature chain.der chain.der.signature

.PHONY: all
all: $(TARGETS)

.PRECIOUS: $(TARGETS)

lets-encrypt-r3.der:
	@echo "### Capturing intermediate certificate"
	wget https://letsencrypt.org/certs/lets-encrypt-r3.der

isrgrootx1.der:
	@echo "### Capturing root certificate"
	wget https://letsencrypt.org/certs/isrgrootx1.der

chain.der: lets-encrypt-r3.der isrgrootx1.der
	cat lets-encrypt-r3.der isrgrootx1.der > $@

%.printcert: %
	keytool -printcert -v -file $^ > $@

%.signature: %
	sha256sum $^ | awk '{print $$1}' > $@

.PHONY: clean
clean:
	rm -f $(TARGETS)
