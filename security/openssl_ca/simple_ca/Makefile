CERTS := ca-cert.pem ca-key.pem server-req.pem server-key.pem server-cert.pem client-req.pem client-key.pem client-cert.pem
CERTS_INFO := ca-cert.pem.text server-cert.pem.text client-cert.pem.text server-cert.pem.verify client-cert.pem.verify

TARGETS := $(CERTS) $(CERTS_INFO)

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	rm -f $(TARGETS)

%.pem.text: %.pem
	@echo "### Generate PEM certificate text"
	openssl x509 -inform PEM -in $^ -noout -text > $@

ca-key.pem:
	@echo "### Generate a private key for the CA"
	openssl genrsa 2048 > ca-key.pem

ca-cert.pem: ca-key.pem
	@echo "### Generate the X509 certificate for the CA"
	openssl req \
		-key $^ \
		-passin pass:test  \
		-new -x509 \
		-days 7300 \
		-sha256 \
		-extensions v3_ca \
		-subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Simple CA" \
		-out $@

server-key.pem:
	@echo "### Generate the private key and certificate request"
	openssl req -newkey rsa:2048 -nodes -days 365000 \
		-passin pass:test \
		-subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Simple Key" \
  	-keyout $@ \
  	-out server-req.pem

server-req.pem: server-key.pem

server-cert.pem: server-key.pem server-req.pem
	@echo "### Generate the X509 certificate for the server"
	$ openssl x509 -req -days 365000 -set_serial 01 \
		-in server-req.pem \
		-out $@ \
		-CA ca-cert.pem \
		-CAkey ca-key.pem

client-key.pem: server-key.pem server-req.pem
	@echo "### Generate the private key and certificate request"
	$ openssl req -newkey rsa:2048 -nodes -days 365000 \
		-passin pass:test \
		-subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Simple Client Key" \
		-keyout $@ \
		-out client-req.pem

client-req.pem: client-key.pem

client-cert.pem: client-key.pem client-req.pem
	@echo "### Generate the X509 certificate for the client"
	$ openssl x509 -req -days 365000 -set_serial 01 \
		-in client-req.pem \
		-out $@  \
		-CA ca-cert.pem \
		-CAkey ca-key.pem

%.verify: %
	$ openssl verify -CAfile ca-cert.pem \
		ca-cert.pem \
		$^ > $@
