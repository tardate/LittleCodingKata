# Self-signed Certs

Creating a self-signed certificate.

## Notes

```sh
mkdir example
cd example
```

### Creating the Certificate Authority's Certificate and Keys

#### Generate a private key for the CA

```sh
$ openssl genrsa 2048 > ca-key.pem
Generating RSA private key, 2048 bit long modulus
........+++
............................+++
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
Common Name (eg, fully qualified host name) []:codingkata.tardate.com
Email Address []:
```

Inspect the certificate:

```sh
$ openssl x509 -in ca-cert.pem -text
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 18111030317579813160 (0xfb574e1e13acc128)
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=SG, L=Singapore, O=LCK, CN=codingkata.tardate.com
        Validity
            Not Before: Jan  5 03:19:43 2022 GMT
            Not After : May  8 03:19:43 3021 GMT
        Subject: C=SG, L=Singapore, O=LCK, CN=codingkata.tardate.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:e5:82:93:30:98:c7:f0:66:81:8b:50:f6:9f:a1:
                    f3:4b:f5:7c:9c:ca:ef:31:51:3d:e8:1b:83:19:fb:
                    83:a3:e9:14:fe:a0:a2:b7:80:b1:c9:02:91:3d:bf:
                    37:4e:3e:c1:f7:f9:6b:a7:6a:97:a1:05:25:62:cc:
                    ad:7b:b5:cb:66:aa:0f:aa:06:09:20:6b:c1:13:b5:
                    3c:61:83:5e:1c:36:f1:26:90:96:5a:f2:4e:c3:3d:
                    d5:ec:8e:73:1f:d7:95:78:65:2a:da:b7:37:fc:4e:
                    15:57:3c:86:c8:ad:45:b8:83:58:99:fd:fd:ea:6f:
                    7f:01:37:e9:b3:d7:37:7f:bc:fa:66:38:4b:8b:67:
                    3f:d1:c9:c3:77:87:93:7a:56:43:a5:9a:65:41:e8:
                    52:c6:43:82:b7:ed:c3:67:16:cb:b2:22:96:ea:4e:
                    4d:d9:b1:55:0f:f2:9e:77:52:08:92:19:b3:d5:ee:
                    86:57:2b:6a:00:71:71:ab:fa:dc:0e:65:d6:cc:5b:
                    e9:78:81:49:54:04:54:c2:a7:94:1d:66:f7:60:ac:
                    6d:7c:5f:d6:e3:f0:d3:bd:4a:e2:33:4f:87:b8:0c:
                    8a:35:f6:da:21:94:ca:86:f7:0a:fa:92:ab:9d:d0:
                    fd:fa:98:af:ed:8b:2f:25:0c:eb:66:d6:80:b3:ef:
                    f7:1f
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha256WithRSAEncryption
            07:99:fa:a7:26:8e:48:da:fd:d6:eb:75:83:40:36:bf:3a:4d:
            5b:4f:dd:b8:9c:db:c9:99:df:d1:a8:f6:d7:fb:eb:0b:4d:31:
            8d:8d:2c:cd:6c:e5:c8:bb:ad:a7:8c:d2:53:1f:0b:fa:ab:76:
            bb:cd:9d:3a:c4:a5:32:4e:bb:5e:67:c5:19:01:4d:d7:fa:ef:
            fc:75:fe:e3:8b:3f:12:4d:b4:49:10:23:5d:8f:59:93:a4:16:
            30:d7:6f:ef:0c:7d:95:2a:c9:da:c9:04:1d:d7:31:e8:a9:9e:
            ea:8e:3f:f0:f2:1f:67:32:02:f7:23:8b:ef:cc:e9:9f:3f:cd:
            da:c0:08:c2:62:9b:31:a9:d4:49:bb:2b:3e:07:63:39:70:58:
            d4:02:92:9c:50:71:cd:cf:c9:c0:0a:de:cb:fd:65:bb:7a:77:
            aa:68:aa:35:f8:29:d1:f2:cf:9b:76:15:9b:47:c4:2d:08:13:
            b3:f3:ce:c4:89:39:8f:9c:9a:59:5b:f4:01:af:0f:96:7e:a0:
            69:90:d2:da:92:60:7f:cb:8c:72:5b:6b:df:22:a4:e7:f6:cb:
            5f:22:57:6d:43:cc:ef:d3:66:22:55:f4:5c:c2:eb:34:41:18:
            89:2d:91:a4:34:ec:c4:ce:b9:a9:4b:37:30:d4:ad:bf:29:a3:
            cf:ed:22:47
-----BEGIN CERTIFICATE-----
MIIDHjCCAgYCCQD7V04eE6zBKDANBgkqhkiG9w0BAQsFADBQMQswCQYDVQQGEwJT
RzESMBAGA1UEBwwJU2luZ2Fwb3JlMQwwCgYDVQQKDANMQ0sxHzAdBgNVBAMMFmNv
ZGluZ2thdGEudGFyZGF0ZS5jb20wIBcNMjIwMTA1MDMxOTQzWhgPMzAyMTA1MDgw
MzE5NDNaMFAxCzAJBgNVBAYTAlNHMRIwEAYDVQQHDAlTaW5nYXBvcmUxDDAKBgNV
BAoMA0xDSzEfMB0GA1UEAwwWY29kaW5na2F0YS50YXJkYXRlLmNvbTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAOWCkzCYx/BmgYtQ9p+h80v1fJzK7zFR
Pegbgxn7g6PpFP6goreAsckCkT2/N04+wff5a6dql6EFJWLMrXu1y2aqD6oGCSBr
wRO1PGGDXhw28SaQllryTsM91eyOcx/XlXhlKtq3N/xOFVc8hsitRbiDWJn9/epv
fwE36bPXN3+8+mY4S4tnP9HJw3eHk3pWQ6WaZUHoUsZDgrftw2cWy7IilupOTdmx
VQ/ynndSCJIZs9XuhlcragBxcav63A5l1sxb6XiBSVQEVMKnlB1m92CsbXxf1uPw
071K4jNPh7gMijX22iGUyob3CvqSq53Q/fqYr+2LLyUM62bWgLPv9x8CAwEAATAN
BgkqhkiG9w0BAQsFAAOCAQEAB5n6pyaOSNr91ut1g0A2vzpNW0/duJzbyZnf0aj2
1/vrC00xjY0szWzlyLutp4zSUx8L+qt2u82dOsSlMk67XmfFGQFN1/rv/HX+44s/
Ek20SRAjXY9Zk6QWMNdv7wx9lSrJ2skEHdcx6Kme6o4/8PIfZzIC9yOL78zpnz/N
2sAIwmKbManUSbsrPgdjOXBY1AKSnFBxzc/JwArey/1lu3p3qmiqNfgp0fLPm3YV
m0fELQgTs/POxIk5j5yaWVv0Aa8Pln6gaZDS2pJgf8uMcltr3yKk5/bLXyJXbUPM
79NmIlX0XMLrNEEYiS2RpDTsxM65qUs3MNStvymjz+0iRw==
-----END CERTIFICATE-----
```

### Creating the Server's Certificate and Keys

#### Generate the private key and certificate request

```sh
$ openssl req -newkey rsa:2048 -nodes -days 365000 -keyout server-key.pem -out server-req.pem
Generating a 2048 bit RSA private key
......................................................................................................................................+++
.........................................................+++
writing new private key to 'server-key.pem'
-----
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
Common Name (eg, fully qualified host name) []:server1.tardate.com
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
```

#### Generate the X509 certificate for the server

```sh
$ openssl x509 -req -days 365000 -set_serial 01 -in server-req.pem -out server-cert.pem -CA ca-cert.pem -CAkey ca-key.pem
Signature ok
subject=/C=SG/L=Singapore/O=LCK/CN=server1.tardate.com
Getting CA Private Key
```

#### Verify the server certificate

```sh
$ openssl verify -CAfile ca-cert.pem ca-cert.pem server-cert.pem
ca-cert.pem: OK
server-cert.pem: OK
```

### Creating the Client's Certificate and Keys

Generate the private key and certificate request

```sh
$ openssl req -newkey rsa:2048 -nodes -days 365000 -keyout client-key.pem -out client-req.pem
Generating a 2048 bit RSA private key
........+++
..............................+++
writing new private key to 'client-key.pem'
-----
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
Common Name (eg, fully qualified host name) []:client1.tardate.com
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
```

Generate the X509 certificate for the client

```sh
$ openssl x509 -req -days 365000 -set_serial 01 -in client-req.pem -out client-cert.pem -CA ca-cert.pem -CAkey ca-key.pem
Signature ok
subject=/C=SG/L=Singapore/O=LCK/CN=client1.tardate.com
Getting CA Private Key
```

Verify the client certificate

```sh
$ openssl verify -CAfile ca-cert.pem ca-cert.pem client-cert.pem
ca-cert.pem: OK
client-cert.pem: OK
```

## Credits and References

* <https://mariadb.com/docs/security/encryption/in-transit/create-self-signed-certificates-keys-openssl/>
* [OpenSSL](https://www.openssl.org/)
