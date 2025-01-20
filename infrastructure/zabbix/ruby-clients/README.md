# #112 Zabbix API Ruby Clients

A quick survey and test of various ruby options for using the Zabbix API.

## Notes

The [Zabbix API](https://www.zabbix.com/documentation/3.0/manual/api) uses the JSON-RPC 2.0 protocol,
and exposes most/all(?) of zabbix functionality for programmatic management.

The tests below use a few API methods, including:

* [user.login](https://www.zabbix.com/documentation/current/manual/api/reference/user/login)
* [apiinfo.version](https://www.zabbix.com/documentation/current/manual/api/reference/apiinfo/version)
* [hostgroup.get](https://www.zabbix.com/documentation/current/manual/api/reference/hostgroup/get)
* [host.get](https://www.zabbix.com/documentation/current/manual/api/reference/host/get)

## Ruby Gems

There are quite a few [Zabbix-related gems on rubygems](https://rubygems.org/search?utf8=%E2%9C%93&query=zabbix).
I've picked a few of the more popular/interesting ones for a test..

| gem                                                          | Last Update          | Comment |
|--------------------------------------------------------------|----------------------|---------|
| [zabbixapi](https://rubygems.org/gems/zabbixapi)             | 2019                 | works well and the most actively maintained?  |
| [zbxapi](https://rubygems.org/gems/zbxapi)                   | 2017                 | quite limited low-level shim to the underlying api  |
| [zabbix-client](https://rubygems.org/gems/zabbix-client)     | 2016                 | thin wrapper on the API, but works well, incl token authenticated |
| [rubix](https://rubygems.org/gems/rubix)                     | 2012                 | basics work, but relatively unfinished and buggy |
| [zabby](https://rubygems.org/gems/zabby)                     | 2012                 | little buggy, no tests  |

## Test Setup

All these tests are running against a plain vanilla Zabbix Appliance running in Docker on the localhost - see [zabbix/dockerized](../dockerized/) for more info.

All the test scripts will pickup configuration from the environment:

```sh
export ZABBIX_API_URL=http://0.0.0.0:80/api_jsonrpc.php
export ZABBIX_API_USERNAME=Admin
export ZABBIX_API_PASSWORD=zabbix
```

Each gem is tested in it's own folder, with its own Gemfile that needs setup:

```sh
cd [test folder]
gem install bundler && bundle install
```

Each has a rake file with some convenience tasks:

```sh
$ rake -T
rake console  # Open an irb session preloaded with this library
rake run      # Run test/demo script
```

### zbxapi test

* [zbxapi](https://github.com/red-tux/zbxapi/) by nelsonab (latest code seems to be on github) - a Ruby wrapper

Comments:

* quite limited low-level shim to the underlying api

Demo..

```sh
$ cd zbxapi_test
$ rake run
/Users/paulgallagher/.rvm/rubies/ruby-2.4.3/bin/ruby basic.rb
connected, api version: 4.4
auth token: a56d0cafa4b2c0f404af8beb246513cc

Getting the list of host groups:
{"groupid"=>"1", "name"=>"Templates", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"2", "name"=>"Linux servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"4", "name"=>"Zabbix servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"5", "name"=>"Discovered hosts", "internal"=>"1", "flags"=>"0"}
{"groupid"=>"6", "name"=>"Virtual machines", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"7", "name"=>"Hypervisors", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"8", "name"=>"Templates/Modules", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"9", "name"=>"Templates/Network devices", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"10", "name"=>"Templates/Operating systems", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"11", "name"=>"Templates/Server hardware", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"12", "name"=>"Templates/Applications", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"13", "name"=>"Templates/Databases", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"14", "name"=>"Templates/Virtualization", "internal"=>"0", "flags"=>"0"}

Getting a specific host:
{"hostid"=>"10084", "proxy_hostid"=>"0", "host"=>"zabbix-app", "status"=>"0", "disable_until"=>"0", "error"=>"", "available"=>"1", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"zabbix-app", "flags"=>"0", "templateid"=>"0", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1", "inventory_mode"=>"1"}
```

### zabby

[zabby](https://github.com/Pragmatic-Source/zabby) by Farzad Farid - a Ruby library and client for Zabbix

Comments:

* has CLI option
* no tests, a few bugs, not actively developed

Demo..

```sh
$ cd zabby_test
$ rake run
/Users/paulgallagher/.rvm/rubies/ruby-2.4.3/bin/ruby basic.rb
auth token: ad98db71638f12391f5cafbc4eb89910

Getting the list of host groups:
{"groupid"=>"1", "name"=>"Templates", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"2", "name"=>"Linux servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"4", "name"=>"Zabbix servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"5", "name"=>"Discovered hosts", "internal"=>"1", "flags"=>"0"}
{"groupid"=>"6", "name"=>"Virtual machines", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"7", "name"=>"Hypervisors", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"8", "name"=>"Templates/Modules", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"9", "name"=>"Templates/Network devices", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"10", "name"=>"Templates/Operating systems", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"11", "name"=>"Templates/Server hardware", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"12", "name"=>"Templates/Applications", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"13", "name"=>"Templates/Databases", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"14", "name"=>"Templates/Virtualization", "internal"=>"0", "flags"=>"0"}

Getting a specific host:
{"hostid"=>"10084", "proxy_hostid"=>"0", "host"=>"zabbix-app", "status"=>"0", "disable_until"=>"0", "error"=>"", "available"=>"1", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"zabbix-app", "flags"=>"0", "templateid"=>"0", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1", "inventory_mode"=>"1"}
```

### zabbixapi

[zabbixapi](https://github.com/express42/zabbixapi) by Express 42.

Comments:

* is pretty tightly bound to API versions
* most actively maintained?
* haven't found a way to use token auth yet

Demo..

```sh
$ cd zabbixapi_test
$ rake run
/Users/paulgallagher/.rvm/rubies/ruby-2.4.3/bin/ruby basic.rb
[WARN] Zabbix API version: 4.4.5 is not supported by this version of zabbixapi
connected, api version: 4.4.5
auth token: 14965f628128c2aa9161a47e737acf20

Getting the list of host groups:
{"groupid"=>"1", "name"=>"Templates", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"2", "name"=>"Linux servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"4", "name"=>"Zabbix servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"5", "name"=>"Discovered hosts", "internal"=>"1", "flags"=>"0"}
{"groupid"=>"6", "name"=>"Virtual machines", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"7", "name"=>"Hypervisors", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"8", "name"=>"Templates/Modules", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"9", "name"=>"Templates/Network devices", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"10", "name"=>"Templates/Operating systems", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"11", "name"=>"Templates/Server hardware", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"12", "name"=>"Templates/Applications", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"13", "name"=>"Templates/Databases", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"14", "name"=>"Templates/Virtualization", "internal"=>"0", "flags"=>"0"}

Getting a specific host:
{"hostid"=>"10084", "proxy_hostid"=>"0", "host"=>"zabbix-app", "status"=>"0", "disable_until"=>"0", "error"=>"", "available"=>"1", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"zabbix-app", "flags"=>"0", "templateid"=>"0", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1", "inventory_mode"=>"1"}
```

### zabbix-client test

[zabbix-client](https://github.com/winebarrel/zabbix-client) by Genki Sugawara.

Comments:

* It's a thin wrapper on the API, but works well.
* supports username/password and token auth

Demo..

```sh
$ cd zabbix_client_test
$ rake run
/Users/paulgallagher/.rvm/rubies/ruby-2.4.3/bin/ruby basic.rb
Connecting with username/password

connected, api version: 4.4.5
auth token: b180eee597c6cf5ebee608a96939e251

Getting the list of host groups:
{"groupid"=>"1", "name"=>"Templates", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"2", "name"=>"Linux servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"4", "name"=>"Zabbix servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"5", "name"=>"Discovered hosts", "internal"=>"1", "flags"=>"0"}
{"groupid"=>"6", "name"=>"Virtual machines", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"7", "name"=>"Hypervisors", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"8", "name"=>"Templates/Modules", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"9", "name"=>"Templates/Network devices", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"10", "name"=>"Templates/Operating systems", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"11", "name"=>"Templates/Server hardware", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"12", "name"=>"Templates/Applications", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"13", "name"=>"Templates/Databases", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"14", "name"=>"Templates/Virtualization", "internal"=>"0", "flags"=>"0"}

Getting a specific host:
{"hostid"=>"10084", "proxy_hostid"=>"0", "host"=>"zabbix-app", "status"=>"0", "disable_until"=>"0", "error"=>"", "available"=>"1", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"zabbix-app", "flags"=>"0", "templateid"=>"0", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1", "inventory_mode"=>"1"}
```

### rubix

[rubix](https://github.com/dhruvbansal/rubix) by Dhruv Bansal - a Ruby library for working with the API and both retrieving and sending data to Zabbix server

Comments:

* the basic API wrapper is simple and functional
* config is global state
* alternative ORM-like interface is unfinished and buggy

Demo..

```sh
$ cd rubix_test
$ rake run
/Users/paulgallagher/.rvm/rubies/ruby-2.4.3/bin/ruby basic.rb

Getting the list of host groups:
{"groupid"=>"1", "name"=>"Templates", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"2", "name"=>"Linux servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"4", "name"=>"Zabbix servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"5", "name"=>"Discovered hosts", "internal"=>"1", "flags"=>"0"}
{"groupid"=>"6", "name"=>"Virtual machines", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"7", "name"=>"Hypervisors", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"8", "name"=>"Templates/Modules", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"9", "name"=>"Templates/Network devices", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"10", "name"=>"Templates/Operating systems", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"11", "name"=>"Templates/Server hardware", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"12", "name"=>"Templates/Applications", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"13", "name"=>"Templates/Databases", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"14", "name"=>"Templates/Virtualization", "internal"=>"0", "flags"=>"0"}

Getting a specific host:
{"hostid"=>"10084", "proxy_hostid"=>"0", "host"=>"zabbix-app", "status"=>"0", "disable_until"=>"0", "error"=>"", "available"=>"1", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"zabbix-app", "flags"=>"0", "templateid"=>"0", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1", "inventory_mode"=>"1"}
```

The gem has a CLI mode:

```sh
$ zabbix_api host.get '{"filter": {"host": "zabbix-app"}}'
{"jsonrpc":"2.0","result":[{"hostid":"10084","proxy_hostid":"0","host":"zabbix-app","status":"0","disable_until":"0","error":"","available":"1","errors_from":"0","lastaccess":"0","ipmi_authtype":"-1","ipmi_privilege":"2","ipmi_username":"","ipmi_password":"","ipmi_disable_until":"0","ipmi_available":"0","snmp_disable_until":"0","snmp_available":"0","maintenanceid":"0","maintenance_status":"0","maintenance_type":"0","maintenance_from":"0","ipmi_errors_from":"0","snmp_errors_from":"0","ipmi_error":"","snmp_error":"","jmx_disable_until":"0","jmx_available":"0","jmx_errors_from":"0","jmx_error":"","name":"zabbix-app","flags":"0","templateid":"0","description":"","tls_connect":"1","tls_accept":"1","tls_issuer":"","tls_subject":"","tls_psk_identity":"","tls_psk":"","proxy_address":"","auto_compress":"1","inventory_mode":"1"}],"id":1}
```
