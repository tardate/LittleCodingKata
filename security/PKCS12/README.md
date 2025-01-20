# #236 PKCS12

About PKCS #12 archive files

## Notes

PKCS #12 defines an archive file format for storing many cryptography objects as a single file. It is commonly used to bundle a private key with its X.509 certificate or to bundle all the members of a chain of trust.

PKCS #12 files are usually created using OpenSSL, which only supports a single private key from the command line interface

GnuTLS's certtool may also be used to create PKCS #12 files including certificates, keys, and CA certificates via --to-p12. However, beware that for interchangeability with other software

### Scripted Generation

See the [example/Makefile](./example/Makefile) for automation of the process described below.
To generate:

```sh
cd example
make clean
make
```

Full make transcript:

```sh
$ make
Generate a private key for the self-signed CA
openssl genrsa 2048 > ca-key.pem
Generating RSA private key, 2048 bit long modulus
............+++
..........................................................+++
e is 65537 (0x10001)
Generate the X509 certificate for the self-signed CA
openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem -subj "/C=SG/L=Singapore/CN=LCK Test CA"
Create PEM key
openssl genrsa 2048 > 2048b-rsa-example-keypair.pem
Generating RSA private key, 2048 bit long modulus
................................................+++
.......................................+++
e is 65537 (0x10001)
Convert PEM to DER key
openssl rsa -inform PEM -in 2048b-rsa-example-keypair.pem -outform DER -out 2048b-rsa-example-keypair.der
writing RSA key
Create PEM request
openssl req -new -key 2048b-rsa-example-keypair.pem -out 2048b-rsa-example-request.pem -subj "/C=SG/L=Singapore/CN=LCK Test Signing Key"
Convert PEM to DER request
openssl req -inform PEM -in 2048b-rsa-example-request.pem -outform DER -out 2048b-rsa-example-request.der
Create PEM certificate
openssl x509 -req -in 2048b-rsa-example-request.pem -days 1825 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 0x01 > 2048b-rsa-example-cert.pem
Signature ok
subject=/C=SG/L=Singapore/CN=LCK Test Signing Key
Getting CA Private Key
Convert PEM to DER certificate
openssl x509 -inform PEM -in 2048b-rsa-example-cert.pem -outform DER -out 2048b-rsa-example-cert.der
Create PKCS12 certificate bundle
openssl pkcs12 -in 2048b-rsa-example-cert.pem -inkey 2048b-rsa-example-keypair.pem -export -out 2048b-rsa-example.p12 -passout pass:test
Analyze/Verify the certificate Bundle
openssl pkcs12 -info -in 2048b-rsa-example.p12 -out 2048b-rsa-example.p12.txt -passin pass:test -passout pass:test
MAC Iteration 2048
MAC verified OK
PKCS7 Encrypted data: pbeWithSHA1And40BitRC2-CBC, Iteration 2048
Certificate bag
PKCS7 Data
Shrouded Keybag: pbeWithSHA1And3-KeyTripleDES-CBC, Iteration 2048
Create PEM with cert chain
cat 2048b-rsa-example-cert.pem ca-cert.pem > chain.pem
Create PKCS12 certificate chain bundle
openssl pkcs12 -in chain.pem -inkey 2048b-rsa-example-keypair.pem -export -out chain.p12 -passout pass:test
Analyze certificate chain bundle
openssl pkcs12 -info -in chain.p12 -out chain.p12.txt -passin pass:test -passout pass:test
MAC Iteration 2048
MAC verified OK
PKCS7 Encrypted data: pbeWithSHA1And40BitRC2-CBC, Iteration 2048
Certificate bag
Certificate bag
PKCS7 Data
Shrouded Keybag: pbeWithSHA1And3-KeyTripleDES-CBC, Iteration 2048
```

### Creating the Certificate Authority's Certificate and Keys

Making a self-signed CA certificate for testing purposes.

#### Generate a private key for the CA

```sh
$ openssl genrsa 2048 > ca-key.pem
Generating RSA private key, 2048 bit long modulus
..........................................................................................................................................+++
.......................+++
e is 65537 (0x10001)
```

#### Generate the X509 certificate for the CA

```sh
$ openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) []:SG
State or Province Name (full name) []:
Locality Name (eg, city) []:Singapore
Organization Name (eg, company) []:LCK
Organizational Unit Name (eg, section) []:
Common Name (eg, fully qualified host name) []:codingkata.tardate.com CA
Email Address []:
```

### How to Make a PKCS #12 archive file

Making a self-signed CA certificate for testing purposes. This is done in the examples folder.

#### Create PEM key

```sh
$ openssl genrsa 2048 > 2048b-rsa-example-keypair.pem
Generating RSA private key, 2048 bit long modulus
..................................................................................+++
................................+++
e is 65537 (0x10001)
```

Convert PEM to DER key

```sh
openssl rsa -inform PEM -in 2048b-rsa-example-keypair.pem -outform DER -out 2048b-rsa-example-keypair.der
```

#### Create PEM request

```sh
$ openssl req -new -key 2048b-rsa-example-keypair.pem -out 2048b-rsa-example-request.pem
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) []:SG
State or Province Name (full name) []:Singapore
Locality Name (eg, city) []:Singapore
Organization Name (eg, company) []:LCK
Organizational Unit Name (eg, section) []:
Common Name (eg, fully qualified host name) []:codingkata.tardate.com
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
```

Convert PEM to DER request

```sh
openssl req -inform PEM -in 2048b-rsa-example-request.pem -outform DER -out 2048b-rsa-example-request.der
```

#### Create PEM certificate

```sh
$ openssl x509 -req -in 2048b-rsa-example-request.pem -days 1825 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 0x01 > 2048b-rsa-example-cert.pem
Signature ok
subject=/C=SG/ST=Singapore/L=Singapore/O=LCK/CN=codingkata.tardate.com
Getting CA Private Key
```

Convert PEM to DER certificate

```sh
openssl x509 -inform PEM -in 2048b-rsa-example-cert.pem -outform DER -out 2048b-rsa-example-cert.der
```

#### Create PKCS12 certificate filebundle

```sh
openssl pkcs12 -in 2048b-rsa-example-cert.pem -inkey 2048b-rsa-example-keypair.pem -export -out 2048b-rsa-example.p12 -passout pass:test
```

### Analyze/Verify The Certificate Bundle

```sh
$ openssl pkcs12 -info -in 2048b-rsa-example.p12 -out 2048b-rsa-example.p12.txt -passin pass:test -passout pass:test
MAC Iteration 2048
MAC verified OK
PKCS7 Encrypted data: pbeWithSHA1And40BitRC2-CBC, Iteration 2048
Certificate bag
PKCS7 Data
Shrouded Keybag: pbeWithSHA1And3-KeyTripleDES-CBC, Iteration 2048
```

### Create with full Chain

```sh
$ cat 2048b-rsa-example-cert.pem ca-cert.pem > chain.pem
$ openssl pkcs12 -in chain.pem -inkey 2048b-rsa-example-keypair.pem -export -out chain.p12 -passout pass:test
$ openssl pkcs12 -info -in chain.p12 -out chain.p12.txt -passin pass:test -passout pass:test
MAC Iteration 2048
MAC verified OK
PKCS7 Encrypted data: pbeWithSHA1And40BitRC2-CBC, Iteration 2048
Certificate bag
Certificate bag
PKCS7 Data
Shrouded Keybag: pbeWithSHA1And3-KeyTripleDES-CBC, Iteration 2048
```

## Credits and References

* [PKCS #12](https://en.wikipedia.org/wiki/PKCS_12) - wikipedia
* [OpenSSL pkcs12 command](https://www.openssl.org/docs/man1.1.1/man1/openssl-pkcs12.html)
* [The GnuTLS Transport Layer Security Library](https://www.gnutls.org/)
