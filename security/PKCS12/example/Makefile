TARGETS := ca-key.pem ca-cert.pem 2048b-rsa-example-keypair.pem 2048b-rsa-example-keypair.der 2048b-rsa-example-request.pem 2048b-rsa-example-request.der 2048b-rsa-example-cert.pem 2048b-rsa-example-cert.der 2048b-rsa-example.p12 2048b-rsa-example.p12.txt chain.pem chain.p12 chain.p12.txt

.PHONY: all
all: $(TARGETS)

ca-key.pem:
	@echo Generate a private key for the self-signed CA
	openssl genrsa 2048 > ca-key.pem

ca-cert.pem: ca-key.pem
	@echo Generate the X509 certificate for the self-signed CA
	openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem -subj "/C=SG/L=Singapore/CN=LCK Test CA"

2048b-rsa-example-keypair.pem:
	@echo Create PEM key
	openssl genrsa 2048 > 2048b-rsa-example-keypair.pem

2048b-rsa-example-keypair.der: 2048b-rsa-example-keypair.pem
	@echo Convert PEM to DER key
	openssl rsa -inform PEM -in 2048b-rsa-example-keypair.pem -outform DER -out 2048b-rsa-example-keypair.der

2048b-rsa-example-request.pem: 2048b-rsa-example-keypair.pem
	@echo Create PEM request
	openssl req -new -key 2048b-rsa-example-keypair.pem -out 2048b-rsa-example-request.pem -subj "/C=SG/L=Singapore/CN=LCK Test Signing Key"

2048b-rsa-example-request.der: 2048b-rsa-example-request.pem
	@echo Convert PEM to DER request
	openssl req -inform PEM -in 2048b-rsa-example-request.pem -outform DER -out 2048b-rsa-example-request.der

2048b-rsa-example-cert.pem: 2048b-rsa-example-request.pem ca-cert.pem ca-key.pem
	@echo Create PEM certificate
	openssl x509 -req -in 2048b-rsa-example-request.pem -days 1825 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 0x01 > 2048b-rsa-example-cert.pem

2048b-rsa-example-cert.der:
	@echo Convert PEM to DER certificate
	openssl x509 -inform PEM -in 2048b-rsa-example-cert.pem -outform DER -out 2048b-rsa-example-cert.der

2048b-rsa-example.p12: 2048b-rsa-example-cert.pem 2048b-rsa-example-keypair.pem
	@echo Create PKCS12 certificate bundle
	openssl pkcs12 -in 2048b-rsa-example-cert.pem -inkey 2048b-rsa-example-keypair.pem -export -out 2048b-rsa-example.p12 -passout pass:test

2048b-rsa-example.p12.txt: 2048b-rsa-example.p12
	@echo Analyze/Verify the certificate Bundle
	openssl pkcs12 -info -in 2048b-rsa-example.p12 -out 2048b-rsa-example.p12.txt -passin pass:test -passout pass:test

chain.pem: 2048b-rsa-example-cert.pem ca-cert.pem
	@echo Create PEM with cert chain
	cat 2048b-rsa-example-cert.pem ca-cert.pem > chain.pem

chain.p12: chain.pem 2048b-rsa-example-keypair.pem
	@echo Create PKCS12 certificate chain bundle
	openssl pkcs12 -in chain.pem -inkey 2048b-rsa-example-keypair.pem -export -out chain.p12 -passout pass:test

chain.p12.txt: chain.p12
	@echo Analyze certificate chain bundle
	openssl pkcs12 -info -in chain.p12 -out chain.p12.txt -passin pass:test -passout pass:test

.PHONY: clean
clean:
	rm -f $(TARGETS)
