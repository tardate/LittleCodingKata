# Python SNMP Servers

Researching simple pure Python SNMP Server options

## Notes

This is just a quick scan to see whether therre are any decent SMPN server implementations in python.

tldr: not really

### Options

A [quick search](https://pypi.org/search/?q=snmp+server) didn't bring much joy. My short-list after a bit more research:

* [snmp-agent](https://pypi.org/project/snmp-agent/) - experimental and minimal SNMP Server implementation.
* [pytest-snmpserver](https://pypi.org/project/pytest-snmpserver/) SNMP server as a pytest plugin
  * I suspect based on [snmp-server](https://github.com/delimitry/snmp-server) however the versions are not aligned, and the egg version does not contain an SNMP server that can be run stand-alone

### Inspecting pytest-snmpserver

Get the source distribution from [pytest-snmpserver](https://pypi.org/project/pytest-snmpserver/)

```
echo "pytest_snmpserver-0.1.9.tar.gz" >> .gitignore
wget https://files.pythonhosted.org/packages/2c/62/da8d213b6f2fc3ef8ab65c0f1df51e21d82a5fbe8c114ff8bf15a3d9eac8/pytest_snmpserver-0.1.9.tar.gz
tar zxvf pytest_snmpserver-0.1.9.tar.gz
```

Inspecting `pytest_snmpserver-0.1.9/pytest_snmpserver/snmp_server.py` and unfortunately it is hard-coded to
run on a specific port and expect a specific request, so not suitable for stand-alone use.

### Using snmp-server

The [snmp-server](https://github.com/delimitry/snmp-server) project on GitHub has a simple pure-python SNMP server.

I *believe* that the [pytest-snmpserver](https://pypi.org/project/pytest-snmpserver/) egg is based on this project,
however the versions are not aligned, and the egg version does not contain an SNMP server that can be run stand-alone

However rhe [snmp-server](https://github.com/delimitry/snmp-server) does run stand-alone...

#### Installing Requirements

This is not distributed as an egg, so installing and running from source.

Just need to clone the repo:

```
$ echo "snmp-server" >> .gitignore
$ python --version
Python 3.7.3
$ git clone git@github.com:delimitry/snmp-server.git
```

#### Running the SNMP Server

```
$ cd snmp-server
$ python snmp-server.py -p 7161
snmp-server.py:18: DeprecationWarning: Using or importing the ABCs from 'collections' instead of from 'collections.abc' is deprecated, and in 3.8 it will stop working
  from collections import Iterable
SNMP server listening on 0.0.0.0:7161
```

#### Testing with snmp cli

$ snmpget -v 2c -c public 0.0.0.0:7161 1.2.3.4.5.6.7.8.9.10.11
iso.2.3.4.5.6.7.8.9.10.11 = STRING: "1.2.3.4.5.6.7.8.9.10.11"

$ snmpwalk -v 2c -c public 0.0.0.0:7161 1.2.3.4.5.6.7.8.9.10.12
iso.2.3.4.5.6.7.8.9.10.12 = STRING: "1.2.3.4.5.6.7.8.9.10.12"

## Credits and References

* [snmp-server](https://github.com/delimitry/snmp-server) - github
* [pytest-snmpserver](https://pypi.org/project/pytest-snmpserver/) - pypi
