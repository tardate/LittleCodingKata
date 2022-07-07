# #xxx Testing RADIUS

Notes about testing RADIUS servers with CHAP and EAP.

## Notes

FreeRADIUS provides a program called radtest, which can be used to test a radius server.

### CHAP

I'm using `radtest` from the [freeradius-server docker image](https://hub.docker.com/r/freeradius/freeradius-server/):

      $ docker run --rm -it freeradius/freeradius-server radtest --help
      Usage: radtest [OPTIONS] user passwd radius-server[:port] nas-port-number secret [ppphint] [nasname]
            -d RADIUS_DIR       Set radius directory
            -t <type>           Set authentication method
                                 type can be pap, chap, mschap, or eap-md5
            -P protocol         Select udp (default) or tcp
            -x                  Enable debug output
            -4                  Use IPv4 for the NAS address (default)
            -6                  Use IPv6 for the NAS address
            -b                  Mandate checks for Blast RADIUS (this is not set by default).

An example successful authentication using PAP (default):

      $ docker run --rm -it freeradius/freeradius-server radtest testuser testpass 192.168.10.85 0 testing123-1
      WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
      Sent Access-Request Id 160 from 0.0.0.0:54365 to 192.168.10.85:1812 length 78
         User-Name = "testuser"
         User-Password = "testpass"
         NAS-IP-Address = 172.17.0.3
         NAS-Port = 0
         Message-Authenticator = 0x00
         Cleartext-Password = "testpass"
      Received Access-Accept Id 160 from 192.168.10.85:1812 to 172.17.0.3:54365 length 38
         Message-Authenticator = 0x41d7a3976633bf456052e8f7c3670119

Using CHAP:

      $ docker run --rm -it freeradius/freeradius-server radtest -t chap testuser testpass 192.168.10.85 0 testing123-1
      WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
      Sent Access-Request Id 170 from 0.0.0.0:59702 to 192.168.10.85:1812 length 79
         User-Name = "testuser"
         CHAP-Password = 0x570b8f020c52423d444b9f7cab59aa921b
         NAS-IP-Address = 172.17.0.3
         NAS-Port = 0
         Message-Authenticator = 0x00
         Cleartext-Password = "testpass"
      Received Access-Accept Id 170 from 192.168.10.85:1812 to 172.17.0.3:59702 length 38
         Message-Authenticator = 0x54b2e35123fc1ac296a2ebe587f35b9e

### EAP

The `radtest` client does not support testing EAP-TLS authentication. However, a program called `eapol_test`, which is apparently part of `wpa_supplicant`, can be used to test EAP-TLS.
See:

* <https://www.systutorials.com/docs/linux/man/8-eapol_test/>
* <https://www.ermitacode.com/eaptest.html>

Download the latest wpa_supplicant from <https://w1.fi/releases/>

Install dependencies

      sudo apt install build-essential pkg-config libnl-3-dev libssl-dev libnl-genl-3-dev

Build eapol_test

      tar -xzvf wpa_supplicant-2.9.tar.gz
      cd wpa_supplicant-2.9/wpa_supplicant
      cp defconfig .config

edit .config and uncomment CONFIG_EAPOL_TEST=y

      make eapol_test

Create a configuration file called eapol_test.conf

      network={
         ssid="Test"
         key_mgmt=WPA-EAP
         eap=TLS
         identity=""
         ca_cert=""
         client_cert=""
         private_key=""
         private_key_passwd=""
         eapol_flags=3
      }

Update the permissions for the configuration file and fill in the values for the empty fields

      chmod 600 eapol_test.conf

Test the RADIUS server.
The `shared_secret` is the secret set on the server in `/etc/freeradius/3.0/clients.conf`

      ./eapol_test -c eapol_test.conf -a x.x.x.x -s "shared_secret"

## Credits and References

* <https://mike-cifelli.gitlab.io/radius/pages/testing/>
* <https://linux.die.net/man/1/radtest>
* <https://wiki.freeradius.org/guide/Radtest>
* <https://hub.docker.com/r/freeradius/freeradius-server/>
