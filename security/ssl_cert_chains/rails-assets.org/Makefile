# https://rails-assets.org/

DOMAIN := rails-assets.org
PORT := 443

SOURCES := certs.pem
# just have to know there are 3 certs->
SPLIT_CERTS_PEM := 0.cert.pem 1.cert.pem 2.cert.pem
INFO := 0.cert.pem.text 0.cert.pem.printcert 1.cert.pem.text 1.cert.pem.printcert 2.cert.pem.text 2.cert.pem.printcert
TARGETS := $(SOURCES) $(SPLIT_CERTS_PEM) $(SPLIT_CERTS_DER) $(INFO) $(CHAIN)

.PHONY: all
all: $(TARGETS)

.PRECIOUS: $(TARGETS)

certs.pem:
	@echo "### Capturing cert chain"
	echo "quit" | openssl s_client -showcerts -servername $(DOMAIN) -connect $(DOMAIN):$(PORT) > $@

%.cert.pem: certs.pem
	cat $^ | awk '/^ $* s:/{flag=1} flag; /-----END/{flag=0}' > $@

%.printcert: %
	keytool -printcert -v -file $^ > $@

%.pem.text: %.pem
	@echo "### Generate PEM certificate text"
	openssl x509 -inform PEM -in $^ -noout -text > $@

%.signature: %
	sha256sum $^ | awk '{print $$1}' > $@

.PHONY: clean
clean:
	rm -f $(TARGETS)
