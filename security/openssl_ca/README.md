# #320 Self-signed Certificates

A guide and automation for generating Self-signed Certificates with OpenSSL.

## Notes

### Basic Self-signed Certificate

Basic steps:

* Generate a Private Key
* Create a Certificate Signing Request (CSR)
* Generate a Self-Signed Certificate
* Verify the Certificate

#### Using the Example Basic SSC Makefile

This example is located in the [basic_ssc](./basic_ssc/) folder. Before running any commands, set the pwd:

    cd simple_ca

The [Makefile](./simple_ca/Makefile) automates the task.

Clean up an earlier run:

    $ make clean
    rm -f private_key.pem csr.pem ssc.pem ssc.pem.text ssc.pem.verify

Generate and verify:

    $ make
    ### generate a 2048-bit RSA private key
    openssl genpkey -algorithm RSA -out private_key.pem -pkeyopt rsa_keygen_bits:2048
    .+..+.+..............+....+......+.....+...+.+.....+.......+.........+...+...........+.+...........+++++++++++++++++++++++++++++++++++++++*..+...+++++++++++++++++++++++++++++++++++++++*.+...+......+..+..........+...+..............+......+....+.....+...+.......+..+.+..+..................+...+......+.+..............+.............+...+.........+.....+....+..+.......+........+...+....+..+....+.....+.+.....+.+...+..+...+.+......+............+...+........+.........+..........+...........+.+...+........+...+.......+..+.............++++++
    ..+.....+....+..+...+......+....+..+....+++++++++++++++++++++++++++++++++++++++*.......+...........+...+.......+..+.+...........+.........+.+...+...+...+.........+.....+......+.+...........+............+.............+....................+.........+...+.+..+....+++++++++++++++++++++++++++++++++++++++*...+.........++++++
    openssl req -new \
                    -subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Basic SSC Key" \
                    -key private_key.pem -out csr.pem
    openssl x509 -req -days 365 -in csr.pem -signkey private_key.pem -out ssc.pem
    Certificate request self-signature ok
    subject=C=SG, ST=Singapore, L=Singapore, O=LCK Pte Ltd, OU=Security, CN=LCK Basic SSC Key
    ### Generate PEM certificate text
    openssl x509 -inform PEM -in ssc.pem -noout -text > ssc.pem.text
    openssl x509 -in ssc.pem -text > ssc.pem.verify

### Simple Self-signed Certificate and CA

The basic steps:

* Creating the Certificate Authority's Certificate and Keys
    * Generate a private key for the CA
    * Generate the X509 certificate for the CA
* Creating the Server's Certificate and Keys
    * Generate the private key and certificate request
    * Generate the X509 certificate for the server
* Creating the Client's Certificate and Keys
    * Generate the private key and certificate request
    * Generate the X509 certificate for the client
* Verifying the Certificates
    * Verify the server certificate
    * Verify the client certificate

#### Using the Example Simple CA Makefile

This example is located in the [simple_ca](./simple_ca/) folder. Before running any commands, set the pwd:

    cd simple_ca

The [Makefile](./simple_ca/Makefile) automates the task. Note that it includes some made-up configuration details and passwords so it runs non-interactively.

Cleanup previous runs:

    $ make clean
    rm -f ca-cert.pem ca-key.pem server-req.pem server-key.pem server-cert.pem client-req.pem client-key.pem client-cert.pem ca-cert.pem.text server-cert.pem.text client-cert.pem.text server-cert.pem.verify client-cert.pem.verify

Generate and verify:

    $ make
    ### Generate a private key for the CA
    openssl genrsa 2048 > ca-key.pem
    ### Generate the X509 certificate for the CA
    openssl req \
                    -key ca-key.pem \
                    -passin pass:test  \
                    -new -x509 \
                    -days 7300 \
                    -sha256 \
                    -extensions v3_ca \
                    -subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Simple CA" \
                    -out ca-cert.pem
    ### Generate the private key and certificate request
    openssl req -newkey rsa:2048 -nodes -days 365000 \
                    -passin pass:test \
                    -subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Simple Key" \
            -keyout server-key.pem \
            -out server-req.pem
    Warning: Ignoring -days without -x509; not generating a certificate
    ...+.+...+++++++++++++++++++++++++++++++++++++++*....+....+..+...+....+..+.............+......+...........+++++++++++++++++++++++++++++++++++++++*.+.+..+...+.......+.....................+..+....+........+.+...........+......+.........+.........+..........+............+.........+........+...+..........+.........+......+...+.....+.......+.....+.......+.....+......+.+......+...+.....+.......+...+...............+..+....+...+......+.....+.+........+......+.+......+..+......+.......+.....+.........+.+...+..+.........+.+...+...........+...+...+...+.........+.+.........+..+.+...+.....+.+.....+...+...+....+.....+.+..+............+....+..+...+..........+.........+.....+..........+...+..+..........+...........+.+.........+..+...+.+...........+.......+...............+..+.+..+...+.........+....+......+.........+.....+....+............+.....+.+...+..+...+.+...+...+.....+.......+...+...+.....+...................+...............+.....+................+...........+..........+........+..........+...........+......+......+...............+.......+........+...+.+.........+...........+.+..+...+.......+........+...+......+....++++++
    ...+...........+.........+......+......+..........+...+..+.+.....+...+......+.+...+..+++++++++++++++++++++++++++++++++++++++*..+......+.....+.+.........+......+...........+....+...+..+...+...+.........+....+.....+.........+.+++++++++++++++++++++++++++++++++++++++*...+.......+..+....+...............+..+............+......+.........+.+..+....+.....+.............+...+..............+....+..+.......+......+..+....+......+.....+...+.+.........+...........+....+..+..................+....+...+...+.....+......+.............+..+....+............+..+...............+......+.........+.+............+..+...+.......+...+.................+.+..+....+.....+....+.....+............+....+.....+.+..+............+...+.+..........................+....+...........+.+...+......+........+.++++++
    -----
    ### Generate the X509 certificate for the server
    openssl x509 -req -days 365000 -set_serial 01 \
                    -in server-req.pem \
                    -out server-cert.pem \
                    -CA ca-cert.pem \
                    -CAkey ca-key.pem
    Certificate request self-signature ok
    subject=C=SG, ST=Singapore, L=Singapore, O=LCK Pte Ltd, OU=Security, CN=LCK Simple Key
    ### Generate the private key and certificate request
    openssl req -newkey rsa:2048 -nodes -days 365000 \
                    -passin pass:test \
                    -subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Simple Client Key" \
                    -keyout client-key.pem \
                    -out client-req.pem
    Warning: Ignoring -days without -x509; not generating a certificate
    .........+...+...+.+........+...+..........+++++++++++++++++++++++++++++++++++++++*.+............+....+......+.....+......+..........+.....+...+++++++++++++++++++++++++++++++++++++++*.....+.+........+.......+........+....+..+.+..+......+.+......+........+.......+...+.........+..+....+......+......+........+.......+..+.+......+.....+..........+...+.....+...+....+...+..+......+.......+..+.+.................+...+...+.......+...+.........+............+.....+...++++++
    .+..+....+.....+...+.............+...+++++++++++++++++++++++++++++++++++++++*.........+..+.+.....+......+.+...+.....+.+........+......+.+......+...............+..............+...+++++++++++++++++++++++++++++++++++++++*.+..+...+......+.+........+.......+...+.........+..+.+.........+......+........+............+....+........+.......+..............+.+...++++++
    -----
    ### Generate the X509 certificate for the client
    openssl x509 -req -days 365000 -set_serial 01 \
                    -in client-req.pem \
                    -out client-cert.pem  \
                    -CA ca-cert.pem \
                    -CAkey ca-key.pem
    Certificate request self-signature ok
    subject=C=SG, ST=Singapore, L=Singapore, O=LCK Pte Ltd, OU=Security, CN=LCK Simple Client Key
    ### Generate PEM certificate text
    openssl x509 -inform PEM -in ca-cert.pem -noout -text > ca-cert.pem.text
    ### Generate PEM certificate text
    openssl x509 -inform PEM -in server-cert.pem -noout -text > server-cert.pem.text
    ### Generate PEM certificate text
    openssl x509 -inform PEM -in client-cert.pem -noout -text > client-cert.pem.text
    openssl verify -CAfile ca-cert.pem \
                    ca-cert.pem \
                    server-cert.pem > server-cert.pem.verify
    openssl verify -CAfile ca-cert.pem \
                    ca-cert.pem \
                    client-cert.pem > client-cert.pem.verify

### Using a Root and Intermediate CA for Self-signed Certificates

Typically, the root CA does not sign server or client certificates directly.
The root CA is only ever used to create one or more intermediate CAs, which are trusted by the root CA to sign certificates on their behalf.
This is best practice. It allows the root key to be kept offline and unused as much as possible, as any compromise of the root key is disastrous.

In this example, we'll generate a root and intermediate CA before generating self-signed server certificates:

The basic process:

* Create the root pair
* Create the intermediate pair
* Sign server and client certificates

#### Using the Example Two-tiered Makefile

This example is located in the [tiered_ca](./tiered_ca/) folder. Before running any commands, set the pwd:

    cd tiered_ca

Ensure that the configuration files for the root and intermediate CAs are appropriate.
These currently contain some made up details for myself:

* [ca_root.cnf](./tiered_ca/ca_root.cnf)
* [ca_intermediate.cnf](./tiered_ca/ca_intermediate.cnf)

Clean up an earlier run:

    $ make clean
    rm -fR root.ca
    rm -fR intermediate.ca
    rm -f root.ca root.ca/private/ca.key.pem root.ca/certs/ca.cert.pem root.ca/certs/ca.cert.der root.ca/certs/ca.cert.pem.text root.ca/certs/ca.cert.pem.printcert intermediate.ca intermediate.ca/private/ca.key.pem intermediate.ca/csr/ca.csr.pem intermediate.ca/certs/ca.cert.pem intermediate.ca/certs/ca.cert.der intermediate.ca/certs/ca.cert.pem.text intermediate.ca/certs/ca.cert.pem.printcert intermediate.ca/certs/chain.pem intermediate.ca/certs/chain.der intermediate.ca/certs/chain.der.signature intermediate.ca/certs/chain.der.printcert

Make all:

    $ make
    mkdir -p root.ca
    mkdir -p root.ca/certs
    mkdir -p root.ca/crl
    mkdir -p root.ca/csr
    mkdir -p root.ca/newcerts
    mkdir -p root.ca/private
    chmod 700 root.ca/private
    touch root.ca/index.txt
    echo 1000 > root.ca/serial
    openssl genrsa -aes256 -passout pass:test -out root.ca/private/ca.key.pem 4096
    chmod 400 root.ca/private/ca.key.pem
    openssl req -config ca_root.cnf \
                    -key root.ca/private/ca.key.pem -passin pass:test  \
                    -new -x509 -days 7300 -sha256 -extensions v3_ca \
                    -subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Test CA" \
                    -out root.ca/certs/ca.cert.pem
    chmod 444 root.ca/certs/ca.cert.pem
    ### Convert PEM to DER certificate
    openssl x509 -inform PEM -in root.ca/certs/ca.cert.pem -outform DER -out root.ca/certs/ca.cert.der
    ### Generate PEM certificate text
    openssl x509 -inform PEM -in root.ca/certs/ca.cert.pem -noout -text > root.ca/certs/ca.cert.pem.text
    keytool -printcert -v -file root.ca/certs/ca.cert.pem > root.ca/certs/ca.cert.pem.printcert
    mkdir -p intermediate.ca
    mkdir -p intermediate.ca/certs
    mkdir -p intermediate.ca/crl
    mkdir -p intermediate.ca/csr
    mkdir -p intermediate.ca/newcerts
    mkdir -p intermediate.ca/private
    chmod 700 intermediate.ca/private
    touch intermediate.ca/index.txt
    echo 1000 > intermediate.ca/serial
    openssl genrsa -aes256 -passout pass:test -out intermediate.ca/private/ca.key.pem 4096
    chmod 400 intermediate.ca/private/ca.key.pem
    openssl req -config ca_intermediate.cnf -new -sha256 \
                    -key intermediate.ca/private/ca.key.pem -passin pass:test \
                    -subj "/C=SG/ST=Singapore/L=Singapore/O=LCK Pte Ltd/OU=Security/CN=LCK Test Intermediate CA" \
                    -out  intermediate.ca/csr/ca.csr.pem
    openssl ca -config ca_root.cnf -batch -extensions v3_intermediate_ca \
                            -passin pass:test  \
          -days 3650 -notext -md sha256 \
          -in intermediate.ca/csr/ca.csr.pem \
          -out intermediate.ca/certs/ca.cert.pem
    Using configuration from ca_root.cnf
    Check that the request matches the signature
    Signature ok
    Certificate Details:
            Serial Number: 4096 (0x1000)
            Validity
                Not Before: Mar 17 05:20:27 2025 GMT
                Not After : Mar 15 05:20:27 2035 GMT
            Subject:
                countryName               = SG
                stateOrProvinceName       = Singapore
                organizationName          = LCK Pte Ltd
                organizationalUnitName    = Security
                commonName                = LCK Test Intermediate CA
            X509v3 extensions:
                X509v3 Subject Key Identifier:
                    5B:7B:AA:17:7E:02:FA:75:15:87:10:FC:B6:69:3D:8F:5C:2E:65:B3
                X509v3 Authority Key Identifier:
                    FA:E9:AE:4B:57:02:0F:10:B9:FA:01:5E:C0:50:37:67:8F:B2:2C:8E
                X509v3 Basic Constraints: critical
                    CA:TRUE, pathlen:0
                X509v3 Key Usage: critical
                    Digital Signature, Certificate Sign, CRL Sign
    Certificate is to be certified until Mar 15 05:20:27 2035 GMT (3650 days)

    Write out database with 1 new entries
    Database updated
    chmod 444 intermediate.ca/certs/ca.cert.pem
    ### Convert PEM to DER certificate
    openssl x509 -inform PEM -in intermediate.ca/certs/ca.cert.pem -outform DER -out intermediate.ca/certs/ca.cert.der
    ### Generate PEM certificate text
    openssl x509 -inform PEM -in intermediate.ca/certs/ca.cert.pem -noout -text > intermediate.ca/certs/ca.cert.pem.text
    keytool -printcert -v -file intermediate.ca/certs/ca.cert.pem > intermediate.ca/certs/ca.cert.pem.printcert
    cat intermediate.ca/certs/ca.cert.pem root.ca/certs/ca.cert.pem > intermediate.ca/certs/chain.pem
    cat intermediate.ca/certs/ca.cert.der root.ca/certs/ca.cert.der > intermediate.ca/certs/chain.der
    ### Generate SHA256 signature
    sha256sum intermediate.ca/certs/chain.der | awk '{print $1}' > intermediate.ca/certs/chain.der.signature
    keytool -printcert -v -file intermediate.ca/certs/chain.der > intermediate.ca/certs/chain.der.printcert

## Some More Makefile Rules for Inspecting Crypto Elements

DER (Distinguished Encoding Rules) is a binary encoding for X.509 certificates and private keys

    %.der.signature: %.der
      @echo "### Generate DER signature"
      sha256sum $^ | awk '{print $$1}' > $@

PKCS #12 defines an archive file format for storing many cryptography objects as a single file. It is commonly used to bundle a private key with its X.509 certificate or to bundle all the members of a chain of trust.

    %.p12.text: %.p12
      @echo "### Analyze certificate bundle"
      openssl pkcs12 -info -in $^ -out $@ -passin pass:fortestingonly -passout pass:fortestingonly

PEM (originally “Privacy Enhanced Mail”) is the most common format for X.509 certificates, CSRs, and cryptographic keys.

    %.printcert: %
      keytool -printcert -v -file $^ > $@

    %.pem.text: %.pem
      @echo "### Generate PEM certificate text"
      openssl x509 -inform PEM -in $^ -noout -text > $@

## Credits and References

* [OpenSSL Certificate Authority](https://jamielinux.com/docs/openssl-certificate-authority/index.html) - jamielinux guide
* [Create a Root CA Certificate](https://www3.rocketsoftware.com/rocketd3/support/documentation/Uniface/10/uniface/security/certificates/createRootCertificate.htm) - rocketsoftware.com
* [Create Self-Signed Certificates and Keys with OpenSSL](https://mariadb.com/docs/server/security/data-in-transit-encryption/create-self-signed-certificates-keys-openssl/) - mariadb
* [PEM, DER, CRT, and CER: X.509 Encodings and Conversions](https://www.ssl.com/guide/pem-der-crt-and-cer-x-509-encodings-and-conversions/)
* OpenSSL docs:
    * [genrsa](https://www.openssl.org/docs/man1.1.1/man1/openssl-genrsa.html) - generate an RSA private key
    * [req](https://www.openssl.org/docs/man1.1.1/man1/openssl-req.html) -  PKCS#10 certificate request and certificate generating utility
    * [ca](https://www.openssl.org/docs/man1.1.1/man1/openssl-ca.html) - sample minimal CA application for signing
