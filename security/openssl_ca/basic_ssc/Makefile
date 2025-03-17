CERTS := private_key.pem csr.pem ssc.pem
CERTS_INFO := ssc.pem.text ssc.pem.verify

TARGETS := $(CERTS) $(CERTS_INFO)

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	rm -f $(TARGETS)

%.pem.text: %.pem
	@echo "### Generate PEM certificate text"
	openssl x509 -inform PEM -in $^ -noout -text > $@

%.verify: %
	openssl x509 -in $^ -text > $@

private_key.pem:
	@echo "### generate a 2048-bit RSA private key"
	openssl genpkey -algorithm RSA -out private_key.pem -pkeyopt rsa_keygen_bits:2048

csr.pem: private_key.pem
	openssl req -new \
		-subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Basic SSC Key" \
		-key $^ -out $@

ssc.pem: csr.pem private_key.pem
	openssl x509 -req -days 365 -in csr.pem -signkey private_key.pem -out $@
