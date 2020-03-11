# Zabbix Programmatic Configuration with Ruby

Configuring zabbix via the API, with examples using zabbix-client ruby gem.

## Notes

The [Zabbix API](https://www.zabbix.com/documentation/3.0/manual/api) uses the JSON-RPC 2.0 protocol,
and exposes most/all(?) of zabbix functionality for programmatic management.

The examples below use API methods to perform the following configuration tasks:

* create a host group
* create a template with a basic ping test item and trigger
* create a host with the template applied

## Test Setup

All these tests are running against a plain vanilla Zabbix Appliance running in Docker on the localhost - see [zabbix/dockerized](../dockerized) for more info.

All the test scripts will pickup configuration from the environment:

```
export ZABBIX_API_URL=http://0.0.0.0:80/api_jsonrpc.php
export ZABBIX_API_USERNAME=Admin
export ZABBIX_API_PASSWORD=zabbix
export ZABBIX_API_TOKEN=existing-token # not required, will be set based on username and password if not provided
```

Installation:

```
gem install bundler && bundle install
```

### Running the Examples

#### Setting a Persistent Token

To re-use a token for subsequent requests, make one query then set the `ZABBIX_API_TOKEN` environment variable accordingly.
For example:

```
$ bundle exec ruby manage.rb hostgroup list
Connecting with username/password
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"groupid"=>"1", "name"=>"Templates", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"2", "name"=>"Linux servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"4", "name"=>"Zabbix servers", "internal"=>"0", "flags"=>"0"}
...etc...
$ export ZABBIX_API_TOKEN=447fc37363a0716ee275cce228b29766
$ bundle exec ruby manage.rb hostgroup list
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"groupid"=>"1", "name"=>"Templates", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"2", "name"=>"Linux servers", "internal"=>"0", "flags"=>"0"}
{"groupid"=>"4", "name"=>"Zabbix servers", "internal"=>"0", "flags"=>"0"}
...etc...
```

#### Host Group

All hosts must belong to a [host group](https://www.zabbix.com/documentation/current/manual/config/hosts).

The example demonstrates list, create and delete host groups.
A gorup called `lck-hostgroup` is created for the purposes of the demo:

```
$ bundle exec ruby manage.rb hostgroup create
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"groupid"=>"18", "name"=>"lck-hostgroup", "internal"=>"0", "flags"=>"0"}

$ bundle exec ruby manage.rb hostgroup list
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
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
{"groupid"=>"18", "name"=>"lck-hostgroup", "internal"=>"0", "flags"=>"0"}

$ bundle exec ruby manage.rb hostgroup delete
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
deleting {"groupid"=>"18", "name"=>"lck-hostgroup", "internal"=>"0", "flags"=>"0"}

$ bundle exec ruby manage.rb hostgroup list
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
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

$ bundle exec ruby manage.rb hostgroup create
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"groupid"=>"19", "name"=>"lck-hostgroup", "internal"=>"0", "flags"=>"0"}
```

#### Templates

[Templates](https://www.zabbix.com/documentation/current/manual/config/templates) are sets of entities that can be conveniently applied to multiple hosts.
Entities may be:

The entities may be:

* items
* triggers
* graphs
* applications
* screens (since Zabbix 2.0)
* low-level discovery rules (since Zabbix 2.0)
* web scenarios (since Zabbix 2.2)

Creating a basic template:

```
$ bundle exec ruby manage.rb template create
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"groupid"=>"19", "name"=>"lck-hostgroup", "internal"=>"0", "flags"=>"0"}
{"proxy_hostid"=>"0", "host"=>"lck-ping-template", "status"=>"3", "disable_until"=>"0", "error"=>"", "available"=>"0", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"lck-ping-template", "flags"=>"0", "templateid"=>"10323", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1"}
```

#### Applications

[Applications](https://www.zabbix.com/documentation/current/manual/api/reference/application) are used to group services by application

Creating an example application and adding it to the template (using the template id as the applicaiton host id):

```
$ bundle exec ruby manage.rb application create
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"proxy_hostid"=>"0", "host"=>"lck-ping-template", "status"=>"3", "disable_until"=>"0", "error"=>"", "available"=>"0", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"lck-ping-template", "flags"=>"0", "templateid"=>"10323", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1"}
{"applicationid"=>"1328", "hostid"=>"10323", "name"=>"lck-status", "flags"=>"0", "templateids"=>[]}
```

Now the application is included in template details:

```
$ bundle exec ruby manage.rb template get 10323
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"proxy_hostid"=>"0", "host"=>"lck-ping-template", "status"=>"3", "disable_until"=>"0", "error"=>"", "available"=>"0", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"lck-ping-template", "flags"=>"0", "templateid"=>"10323", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1", "items"=>[], "triggers"=>[], "applications"=>[{"applicationid"=>"1328"}]}
```

#### Items

[Items](https://www.zabbix.com/documentation/current/manual/config/items) define individual metrics that are actually collected.

Creating an example ping item and adding it to the template:

```
$ bundle exec ruby manage.rb item create
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"proxy_hostid"=>"0", "host"=>"lck-ping-template", "status"=>"3", "disable_until"=>"0", "error"=>"", "available"=>"0", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"lck-ping-template", "flags"=>"0", "templateid"=>"10323", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1"}
{"proxy_hostid"=>"0", "host"=>"lck-ping-template", "status"=>"3", "disable_until"=>"0", "error"=>"", "available"=>"0", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"lck-ping-template", "flags"=>"0", "templateid"=>"10323", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1"}
{"applicationid"=>"1328", "hostid"=>"10323", "name"=>"lck-status", "flags"=>"0", "templateids"=>[]}
{"itemid"=>"30474", "type"=>"3", "snmp_community"=>"", "snmp_oid"=>"", "hostid"=>"10323", "name"=>"lck-ping", "key_"=>"icmpping", "delay"=>"30s", "history"=>"90d", "trends"=>"365d", "status"=>"0", "value_type"=>"3", "trapper_hosts"=>"", "units"=>"", "snmpv3_securityname"=>"", "snmpv3_securitylevel"=>"0", "snmpv3_authpassphrase"=>"", "snmpv3_privpassphrase"=>"", "formula"=>"", "logtimefmt"=>"", "templateid"=>"0", "valuemapid"=>"1", "params"=>"", "ipmi_sensor"=>"", "authtype"=>"0", "username"=>"", "password"=>"", "publickey"=>"", "privatekey"=>"", "flags"=>"0", "interfaceid"=>"0", "port"=>"", "description"=>"", "inventory_link"=>"0", "lifetime"=>"30d", "snmpv3_authprotocol"=>"0", "snmpv3_privprotocol"=>"0", "snmpv3_contextname"=>"", "evaltype"=>"0", "jmx_endpoint"=>"", "master_itemid"=>"0", "timeout"=>"3s", "url"=>"", "query_fields"=>[], "posts"=>"", "status_codes"=>"200", "follow_redirects"=>"1", "post_type"=>"0", "http_proxy"=>"", "headers"=>[], "retrieve_mode"=>"0", "request_method"=>"0", "output_format"=>"0", "ssl_cert_file"=>"", "ssl_key_file"=>"", "ssl_key_password"=>"", "verify_peer"=>"0", "verify_host"=>"0", "allow_traps"=>"0", "state"=>"0", "error"=>"", "lastclock"=>"0", "lastns"=>"0", "lastvalue"=>"0", "prevvalue"=>"0"}
```

#### Triggers

[Triggers](https://www.zabbix.com/documentation/current/manual/config/triggers) are logical expressions that evaluate data gathered by items

Creating an example ping trigger and adding it to the template:

```
$ bundle exec ruby manage.rb trigger create
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"proxy_hostid"=>"0", "host"=>"lck-ping-template", "status"=>"3", "disable_until"=>"0", "error"=>"", "available"=>"0", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"lck-ping-template", "flags"=>"0", "templateid"=>"10323", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1"}
{"triggerid"=>"16749", "expression"=>"{19619}=0", "description"=>"lck-ping-status", "url"=>"", "status"=>"0", "value"=>"0", "priority"=>"4", "lastchange"=>"0", "comments"=>"Last three attempts returned timeout. Please check device connectivity.", "error"=>"", "templateid"=>"0", "type"=>"0", "state"=>"0", "flags"=>"0", "recovery_mode"=>"0", "recovery_expression"=>"", "correlation_mode"=>"0", "correlation_tag"=>"", "manual_close"=>"0", "opdata"=>""}
```

Now we have a basic template with a ping trigger:

```
$ bundle exec ruby manage.rb template get 10323
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"proxy_hostid"=>"0", "host"=>"lck-ping-template", "status"=>"3", "disable_until"=>"0", "error"=>"", "available"=>"0", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"lck-ping-template", "flags"=>"0", "templateid"=>"10323", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1", "items"=>[{"itemid"=>"30474"}], "triggers"=>[{"triggerid"=>"16749"}], "applications"=>[{"applicationid"=>"1328"}]}
```


#### Host

[Hosts](https://www.zabbix.com/documentation/current/manual/config/hosts) are the devices you wish to monitor.

Creating an example host (`codingkata.tardate.com`) and applying the `lck-ping-template`:

```
$ bundle exec ruby manage.rb host create
Connecting with auth token
API version: 4.4.5. Connected with token: 447fc37363a0716ee275cce228b29766
{"groupid"=>"19", "name"=>"lck-hostgroup", "internal"=>"0", "flags"=>"0"}
{"proxy_hostid"=>"0", "host"=>"lck-ping-template", "status"=>"3", "disable_until"=>"0", "error"=>"", "available"=>"0", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"lck-ping-template", "flags"=>"0", "templateid"=>"10323", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1"}
{"hostid"=>"10324", "proxy_hostid"=>"0", "host"=>"codingkata.tardate.com", "status"=>"0", "disable_until"=>"0", "error"=>"", "available"=>"0", "errors_from"=>"0", "lastaccess"=>"0", "ipmi_authtype"=>"-1", "ipmi_privilege"=>"2", "ipmi_username"=>"", "ipmi_password"=>"", "ipmi_disable_until"=>"0", "ipmi_available"=>"0", "snmp_disable_until"=>"0", "snmp_available"=>"0", "maintenanceid"=>"0", "maintenance_status"=>"0", "maintenance_type"=>"0", "maintenance_from"=>"0", "ipmi_errors_from"=>"0", "snmp_errors_from"=>"0", "ipmi_error"=>"", "snmp_error"=>"", "jmx_disable_until"=>"0", "jmx_available"=>"0", "jmx_errors_from"=>"0", "jmx_error"=>"", "name"=>"codingkata.tardate.com", "flags"=>"0", "templateid"=>"0", "description"=>"", "tls_connect"=>"1", "tls_accept"=>"1", "tls_issuer"=>"", "tls_subject"=>"", "tls_psk_identity"=>"", "tls_psk"=>"", "proxy_address"=>"", "auto_compress"=>"1", "inventory_mode"=>"-1"}
```

Now we have basic ping monitoring running for the host:

![lck-ping-graph](./assets/lck-ping-graph.png?raw=true)

## Credits and References

* [Zabbix API](https://www.zabbix.com/documentation/3.0/manual/api)
* [zabbix-client](https://rubygems.org/gems/zabbix-client)
