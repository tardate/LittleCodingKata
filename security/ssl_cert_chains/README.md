# #182 SSL Certificate Chains

notes on investigating issues with server SSL certificate chains.

> In the following notes, I have used the url `https://www.redacted-domain.name/` in place of the actual site in question
> to obscure the identity of the site (as it is not particularly relevant).
> Hence: commands shown here using that url will not work as-is - they need a real url substituted first!

## Notes

I just encountered a site with an SSL certificate signed by Sectigo (formerly Comodo):

* Sectigo RSA Domain Validation Secure Server CA (Intermediate certificate authority)
* in turn signed by USERTrust RSA Certification Authority (Root certificate authority)

The site worked fine in browsers (Chrome, Firefox etc), and the certificate chain was all ok when viewed with
the browser's certificate inspection feature.

But I was seeing SSL verification errors when using command line utilities, specifically curl:

```sh
$ curl https://www.redacted-domain.name/
curl: (60) SSL certificate problem: certificate has expired
More details here: https://curl.haxx.se/docs/sslcerts.html

curl performs SSL certificate verification by default, using a "bundle"
 of Certificate Authority (CA) public keys (CA certs). If the default
 bundle file isn't adequate, you can specify an alternate file
 using the --cacert option.
If this HTTPS server uses a certificate signed by a CA represented in
 the bundle, the certificate verification probably failed due to a
 problem with the certificate (it might be expired, or the name might
 not match the domain name in the URL).
If you'd like to turn off curl's verification of the certificate, use
 the -k (or --insecure) option.
HTTPS-proxy has similar options --proxy-cacert and --proxy-insecure.
```

## First Thought

My first thought was to suspect an old CA certificate bundle - a common enough occurrence on macOS,
especially when I'm running an old version, and there can be confusion as to which cert bundle is being used (system? brew-installed utilities and openssl? etc).

Apple Support provide details of the root certificates shipped with each version.
e.g. [here for for High Sierra](https://support.apple.com/en-gb/HT208127).
and one can inspect locally at `file:///System/Library/Security/Certificates.bundle/Contents/Resources/TrustStore.html`
or with the Keychain Access utility program.

However a quick check with one of the many SSL verification utilities on the net -
[www.sslshopper.com](https://www.sslshopper.com/ssl-checker.html#hostname=https://www.redacted-domain.name/) -
showed there was in fact an issue with the certificates being provided by the server.

It was reporting "One of the root or intermediate certificates has expired (367 days ago)."

Server certificate:

```sh
Common name: www.redacted-domain.name
SANs: *.redacted-domain.name, redacted-domain.name
Valid from February 26, 2020 to March 28, 2022
Serial Number: aebde0ab25f78379378654874b7082bf
Signature Algorithm: sha256WithRSAEncryption
Issuer: Sectigo RSA Domain Validation Secure Server CA
```

Intermediate:

```sh
Common name: Sectigo RSA Domain Validation Secure Server CA
Organization: Sectigo Limited
Location: Salford, Greater Manchester, GB
Valid from November 1, 2018 to December 31, 2030
Serial Number: 7d5b5126b476ba11db74160bbc530da7
Signature Algorithm: sha384WithRSAEncryption
Issuer: USERTrust RSA Certification Authority
```

Root:

```sh
Common name: USERTrust RSA Certification Authority
Organization: The USERTRUST Network
Location: Jersey City, New Jersey, US
Valid from May 30, 2000 to May 30, 2020
Serial Number: 13ea28705bf4eced0c36630980614336
Signature Algorithm: sha384WithRSAEncryption
Issuer: AddTrust External CA Root
```

## openssl

The following steps will use [openssl](https://www.openssl.org/) to inspect the server cert chain.
Per my installation:

```sh
    $ which openssl
    /usr/bin/openssl
    $ openssl version -d
    OPENSSLDIR: "/private/etc/ssl"
    $ openssl version
    LibreSSL 2.2.7
```

## Using openssl to Extract/examine Site Certificate Details

The [openssl s_client](https://www.openssl.org/docs/man1.0.2/man1/s_client.html)
command can be used to test a specific server connection.

Here's a command that I used to extract the certificates offered by the server to a file `failing-cacert.pem`

```sh
echo "quit" | openssl s_client -showcerts -servername www.redacted-domain.name -connect www.redacted-domain.name:443 > failing-cacert.pem
```

There are actually 3 certificates downloaded: the server, and intermediated. and a root certificate.

The [openssl x509](https://www.openssl.org/docs/man1.0.2/man1/x509.html) command can be used to inspect the certificates.
But it can only handle one at a time, so this little awk expressions extracts the root certificate (number '2') for inspection.

This shows the certificate expired May 30 10:48:38 2020 GMT.

```sh
$ cat failing-cacert.pem | awk '/^ 2 s:/{flag=1} flag; /-----END/{flag=0}' | openssl x509 -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            13:ea:28:70:5b:f4:ec:ed:0c:36:63:09:80:61:43:36
    Signature Algorithm: sha384WithRSAEncryption
        Issuer: C=SE, O=AddTrust AB, OU=AddTrust External TTP Network, CN=AddTrust External CA Root
        Validity
            Not Before: May 30 10:48:38 2000 GMT
            Not After : May 30 10:48:38 2020 GMT
        Subject: C=US, ST=New Jersey, L=Jersey City, O=The USERTRUST Network, CN=USERTrust RSA Certification Authority
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (4096 bit)
                Modulus:
                    00:80:12:65:17:36:0e:c3:db:08:b3:d0:ac:57:0d:
                    76:ed:cd:27:d3:4c:ad:50:83:61:e2:aa:20:4d:09:
                    2d:64:09:dc:ce:89:9f:cc:3d:a9:ec:f6:cf:c1:dc:
                    f1:d3:b1:d6:7b:37:28:11:2b:47:da:39:c6:bc:3a:
                    19:b4:5f:a6:bd:7d:9d:a3:63:42:b6:76:f2:a9:3b:
                    2b:91:f8:e2:6f:d0:ec:16:20:90:09:3e:e2:e8:74:
                    c9:18:b4:91:d4:62:64:db:7f:a3:06:f1:88:18:6a:
                    90:22:3c:bc:fe:13:f0:87:14:7b:f6:e4:1f:8e:d4:
                    e4:51:c6:11:67:46:08:51:cb:86:14:54:3f:bc:33:
                    fe:7e:6c:9c:ff:16:9d:18:bd:51:8e:35:a6:a7:66:
                    c8:72:67:db:21:66:b1:d4:9b:78:03:c0:50:3a:e8:
                    cc:f0:dc:bc:9e:4c:fe:af:05:96:35:1f:57:5a:b7:
                    ff:ce:f9:3d:b7:2c:b6:f6:54:dd:c8:e7:12:3a:4d:
                    ae:4c:8a:b7:5c:9a:b4:b7:20:3d:ca:7f:22:34:ae:
                    7e:3b:68:66:01:44:e7:01:4e:46:53:9b:33:60:f7:
                    94:be:53:37:90:73:43:f3:32:c3:53:ef:db:aa:fe:
                    74:4e:69:c7:6b:8c:60:93:de:c4:c7:0c:df:e1:32:
                    ae:cc:93:3b:51:78:95:67:8b:ee:3d:56:fe:0c:d0:
                    69:0f:1b:0f:f3:25:26:6b:33:6d:f7:6e:47:fa:73:
                    43:e5:7e:0e:a5:66:b1:29:7c:32:84:63:55:89:c4:
                    0d:c1:93:54:30:19:13:ac:d3:7d:37:a7:eb:5d:3a:
                    6c:35:5c:db:41:d7:12:da:a9:49:0b:df:d8:80:8a:
                    09:93:62:8e:b5:66:cf:25:88:cd:84:b8:b1:3f:a4:
                    39:0f:d9:02:9e:eb:12:4c:95:7c:f3:6b:05:a9:5e:
                    16:83:cc:b8:67:e2:e8:13:9d:cc:5b:82:d3:4c:b3:
                    ed:5b:ff:de:e5:73:ac:23:3b:2d:00:bf:35:55:74:
                    09:49:d8:49:58:1a:7f:92:36:e6:51:92:0e:f3:26:
                    7d:1c:4d:17:bc:c9:ec:43:26:d0:bf:41:5f:40:a9:
                    44:44:f4:99:e7:57:87:9e:50:1f:57:54:a8:3e:fd:
                    74:63:2f:b1:50:65:09:e6:58:42:2e:43:1a:4c:b4:
                    f0:25:47:59:fa:04:1e:93:d4:26:46:4a:50:81:b2:
                    de:be:78:b7:fc:67:15:e1:c9:57:84:1e:0f:63:d6:
                    e9:62:ba:d6:5f:55:2e:ea:5c:c6:28:08:04:25:39:
                    b8:0e:2b:a9:f2:4c:97:1c:07:3f:0d:52:f5:ed:ef:
                    2f:82:0f
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Authority Key Identifier:
                keyid:AD:BD:98:7A:34:B4:26:F7:FA:C4:26:54:EF:03:BD:E0:24:CB:54:1A

            X509v3 Subject Key Identifier:
                53:79:BF:5A:AA:2B:4A:CF:54:80:E1:D8:9B:C0:9D:F2:B2:03:66:CB
            X509v3 Key Usage: critical
                Digital Signature, Certificate Sign, CRL Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
            X509v3 Certificate Policies:
                Policy: X509v3 Any Policy

            X509v3 CRL Distribution Points:

                Full Name:
                  URI:http://crl.usertrust.com/AddTrustExternalCARoot.crl

            Authority Information Access:
                OCSP - URI:http://ocsp.usertrust.com

    Signature Algorithm: sha384WithRSAEncryption
         93:65:f6:37:83:95:0f:5e:c3:82:1c:1f:d6:77:e7:3c:8a:c0:
         aa:09:f0:e9:0b:26:f1:e0:c2:6a:75:a1:c7:79:c9:b9:52:60:
         c8:29:12:0e:f0:ad:03:d6:09:c4:76:df:e5:a6:81:95:a7:46:
         da:82:57:a9:95:92:c5:b6:8f:03:22:6c:33:77:c1:7b:32:17:
         6e:07:ce:5a:14:41:3a:05:24:1b:f6:14:06:3b:a8:25:24:0e:
         bb:cc:2a:75:dd:b9:70:41:3f:7c:d0:63:36:21:07:1f:46:ff:
         60:a4:91:e1:67:bc:de:1f:7e:19:14:c9:63:67:91:ea:67:07:
         6b:b4:8f:8b:c0:6e:43:7d:c3:a1:80:6c:b2:1e:bc:53:85:7d:
         dc:90:a1:a4:bc:2d:ef:46:72:57:35:05:bf:bb:46:bb:6e:6d:
         37:99:b6:ff:23:92:91:c6:6e:40:f8:8f:29:56:ea:5f:d5:5f:
         14:53:ac:f0:4f:61:ea:f7:22:cc:a7:56:0b:e2:b8:34:1f:26:
         d9:7b:19:05:68:3f:ba:3c:d4:38:06:a2:d3:e6:8f:0e:e3:b4:
         71:6d:40:42:c5:84:b4:40:95:2b:f4:65:a0:48:79:f6:1d:81:
         63:96:9d:4f:75:e0:f8:7c:e4:8e:a9:d1:f2:ad:8a:b3:8c:c7:
         21:cd:c2:ef
```

## Conclusion

Having identified the certificate issue I was able to report the problem to the site owner.

In the meantime, I will disable SSL verification where necessary e.g. with curl, the `-k` option:

```sh
curl https://www.redacted-domain.name/ # curl: (60) SSL certificate problem: certificate has expired
curl -k https://www.redacted-domain.name/ # works
```

## Credits and References

* [new CA Sectigo(formerly Comodo) not trusted](https://live.paloaltonetworks.com/t5/general-topics/new-ca-sectigo-formerly-comodo-not-trusted/td-p/301356)
* [Syncing macOS Keychain certificates with Homebrew's OpenSSL](https://akrabat.com/syncing-macos-keychain-certificates-with-homebrews-openssl/)
* [openssl s_client doc](https://www.openssl.org/docs/man1.0.2/man1/s_client.html)
