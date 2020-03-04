# About InfluxDB

Learning the basics of InfluxDB and running a demo with Docker.

## Notes

These notes were originally made using InfluxDb v2 alpha. Currently updated for InfluxDb v2 beta.

There are [major changes](https://v2.docs.influxdata.com/v2.0/reference/release-notes/influxdb/) in commands/usage from 1.x,
and of course the details below may change.

See [Using InfluxDb with Ruby](../ruby_client) for an example of using InfluxDB 1.7 with docker.

## Architectural Components

| Compontent | Purpose |
|------------|---------|
| InfluxDB   | Time-Series Data Storage       |
| Telegraf   | Time-Series Data Collector     |
| Chronograf | Time-Series Data Visualization |
| Kapacitor  | Time-Series Data Processing    |

## Running With Docker

### InfluxDB Docker Control

The `influx_control.sh` script is a simple wrapper for the main operations:

Startup:

    $ ./influx_control.sh start
    Stopping/removing any previous docker container..
    Error response from daemon: No such container: myinfluxdb
    Error: No such container: myinfluxdb
    Starting  container with web access on port 9999..
    594b4dfbc7401afc4d7626b97e4c0b1e888b077e9b1a3e5318209b81fe4cee2e

Shutdown:

    $ ./influx_control.sh stop
    Stopping/removing any previous docker container..
    myinfluxdb
    myinfluxdb


These start a docker image with admin console available on [localhost:9999](http://localhost:9999).
It maps the database storage to `myinfluxdb/data` on the local filesystem.

Hitting [localhost:9999](http://localhost:9999) for the first time will prompt for the creationg of a user, organisation and bucket.
For a first test, I used:

* admin/password
* org: lck
* bucket: demo1

## Writing Data

InfluxDB supports the following methods:

* User Interface - manual data entry using the line protocol
* influx CLI - using the [`influx write`](https://v2.docs.influxdata.com/v2.0/reference/cli/influx/write/) command
* InfluxDB API - an HTTP request to the InfluxDB API /write endpoint

### Creating a Token

From the `Load Data > Tokens` menu:

![create_token](./assets/create_token.png?raw=true)

### Writing Some Data with Curl

Posting some data using the token created in the pervious step:

```
curl -XPOST "http://localhost:9999/api/v2/write?org=lck&bucket=demo1&precision=s" \
  --header "Authorization: Token s1-6tIH6IWHbfWTeW3C0deVr1ZXivAjQFXdpwdUzCgmLemMX_K26fae6ziA5S6ooAHJokEHlcz1ZCb5c91sl0A==" \
  --data-raw "mem,host=host1 used_percent=23.43234543 1577674077"
curl -XPOST "http://localhost:9999/api/v2/write?org=lck&bucket=demo1&precision=s" \
  --header "Authorization: Token s1-6tIH6IWHbfWTeW3C0deVr1ZXivAjQFXdpwdUzCgmLemMX_K26fae6ziA5S6ooAHJokEHlcz1ZCb5c91sl0A==" \
  --data-raw "mem,host=host1 used_percent=33.43234543 1577675077"
curl -XPOST "http://localhost:9999/api/v2/write?org=lck&bucket=demo1&precision=s" \
  --header "Authorization: Token s1-6tIH6IWHbfWTeW3C0deVr1ZXivAjQFXdpwdUzCgmLemMX_K26fae6ziA5S6ooAHJokEHlcz1ZCb5c91sl0A==" \
  --data-raw "mem,host=host1 used_percent=35.43234543 1577676077"
```

These are three samples with second-level precision. Measurement=`mem`, field=`user_percent` with a host filter.
The Data Explorer can be used to example the loaded data:

![data_explorer](./assets/data_explorer.png?raw=true)

## Credits and References

* [InfluxDB home](https://www.influxdata.com/) - influxdata
* [Get started with InfluxDB 2.0](https://v2.docs.influxdata.com/v2.0/get-started/)
* [influxdb repo builds](https://quay.io/repository/influxdb/influxdb?tab=info)
