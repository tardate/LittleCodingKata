CA := root.ca root.ca/private/ca.key.pem root.ca/certs/ca.cert.pem root.ca/certs/ca.cert.der
CA_INFO := root.ca/certs/ca.cert.pem.text root.ca/certs/ca.cert.pem.printcert
CA_ALL := $(CA) $(CA_INFO)
INTERMEDIATE_CA := intermediate.ca intermediate.ca/private/ca.key.pem intermediate.ca/csr/ca.csr.pem intermediate.ca/certs/ca.cert.pem intermediate.ca/certs/ca.cert.der
INTERMEDIATE_CHAIN := intermediate.ca/certs/chain.pem intermediate.ca/certs/chain.der intermediate.ca/certs/chain.der.signature intermediate.ca/certs/chain.der.printcert
INTERMEDIATE_CA_INFO := intermediate.ca/certs/ca.cert.pem.text intermediate.ca/certs/ca.cert.pem.printcert
INTERMEDIATE_ALL := $(INTERMEDIATE_CA) $(INTERMEDIATE_CA_INFO) $(INTERMEDIATE_CHAIN)

TARGETS := $(CA_ALL) $(INTERMEDIATE_ALL)

.PRECIOUS: $(TARGETS)

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	rm -fR root.ca
	rm -fR intermediate.ca
	rm -f $(TARGETS)

%.printcert: %
	keytool -printcert -v -file $^ > $@

%.pem.text: %.pem
	@echo "### Generate PEM certificate text"
	openssl x509 -inform PEM -in $^ -noout -text > $@

%.der: %.pem
	@echo "### Convert PEM to DER certificate"
	openssl x509 -inform PEM -in $^ -outform DER -out $@

%.signature: %
	@echo "### Generate SHA256 signature"
	sha256sum $^ | awk '{print $$1}' > $@

%.ca:
	mkdir -p $@
	mkdir -p $@/certs
	mkdir -p $@/crl
	mkdir -p $@/csr
	mkdir -p $@/newcerts
	mkdir -p $@/private
	chmod 700 $@/private
	touch $@/index.txt
	echo 1000 > $@/serial

%.key.pem:
	openssl genrsa -aes256 -passout pass:test -out $@ 4096
	chmod 400 $@

root.ca/certs/ca.cert.pem: root.ca/private/ca.key.pem
	openssl req -config ca_root.cnf \
		-key root.ca/private/ca.key.pem -passin pass:test  \
		-new -x509 -days 7300 -sha256 -extensions v3_ca \
		-subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Test CA" \
		-out $@
	chmod 444 $@

intermediate.ca/csr/ca.csr.pem: intermediate.ca/private/ca.key.pem
	openssl req -config ca_intermediate.cnf -new -sha256 \
		-key $^ -passin pass:test \
		-subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Test Intermediate CA" \
		-out  $@

intermediate.ca/certs/ca.cert.pem: intermediate.ca/csr/ca.csr.pem
	openssl ca -config ca_root.cnf -batch -extensions v3_intermediate_ca \
			-passin pass:test  \
      -days 3650 -notext -md sha256 \
      -in $^ \
      -out $@
	chmod 444 $@

intermediate.ca/certs/chain.pem: intermediate.ca/certs/ca.cert.pem root.ca/certs/ca.cert.pem
	cat intermediate.ca/certs/ca.cert.pem root.ca/certs/ca.cert.pem > $@

intermediate.ca/certs/chain.der: intermediate.ca/certs/ca.cert.der root.ca/certs/ca.cert.der
	cat intermediate.ca/certs/ca.cert.der root.ca/certs/ca.cert.der > $@
