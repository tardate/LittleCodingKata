# openssl_ca

__subtitle__

## Notes

Prepare the directory
Prepare the configuration file

Create the root certificate

Create the root key
[genrsa](https://www.openssl.org/docs/man1.1.1/man1/openssl-genrsa.html)

Create the root certificate
[req](https://www.openssl.org/docs/man1.1.1/man1/openssl-req.html)

Sign
[ca](https://www.openssl.org/docs/man1.1.1/man1/openssl-ca.html)

Create the intermediate certificate

## Credits and References

* [name](https://jamielinux.com/docs/openssl-certificate-authority/index.html)
* [name](https://www3.rocketsoftware.com/rocketd3/support/documentation/Uniface/10/uniface/security/certificates/createRootCertificate.htm)
* [name](https://mariadb.com/docs/security/encryption/in-transit/create-self-signed-certificates-keys-openssl/)
* [name](url)

%.der.signature: %.der
  @echo "### Generate DER signature"
  sha256sum $^ | awk '{print $$1}' > $@

%.p12.text: %.p12
  @echo "### Analyze certificate bundle"
  openssl pkcs12 -info -in $^ -out $@ -passin pass:fortestingonly -passout pass:fortestingonly

%.printcert: %
  keytool -printcert -v -file $^ > $@

%.pem.text: %.pem
  @echo "### Generate PEM certificate text"
  openssl x509 -inform PEM -in $^ -noout -text > $@
