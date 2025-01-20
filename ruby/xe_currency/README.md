# #266 xe_currency

Using the Xe Currency Data API from Ruby and with curl.

## Notes

Xe have been a trusted [currency data source](https://www.xe.com/xecurrencydata/) for over 25 years.
They provide an API for programmatic access to current and historical exchange rates.
It is a paid service, but a limited-time free trial is available.

### curl and bash example

The [xe.sh](./xe.sh) script is a simple bash script example of calling the API with curl.

    $ ./xe.sh account_info
    ######################################################################## 100.0%
    {
      "id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxxxxx",
      "organization": "xxxxxxxxxxxx",
      "package": "FREETRIAL_DAILY_REAL_DATA",
      "service_start_timestamp": "2023-07-14T00:00:00Z",
      "service_end_timestamp": "2023-07-22T00:00:00Z",
      "package_limit": 10000,
      "package_limit_remaining": 9995
    }

    $ ./xe.sh currencies | more
    ######################################################################## 100.0%
    {
      "terms": "http://www.xe.com/legal/dfs.php",
      "privacy": "http://www.xe.com/privacy.php",
      "currencies": [
        {
          "iso": "AED",
          "currency_name": "Emirati Dirham",
          "is_obsolete": false
        },
        {
          "iso": "AFN",
          "currency_name": "Afghan Afghani",
          "is_obsolete": false
        },
        {
          "iso": "ALL",
          "currency_name": "Albanian Lek",
          "is_obsolete": false
        },
        {
          "iso": "AMD",
          "currency_name": "Armenian Dram",
          "is_obsolete": false
        },
    ...

Single currency conversion:

    $ ./xe.sh SGD to USD
    ######################################################################## 100.0%
    {
      "terms": "http://www.xe.com/legal/dfs.php",
      "privacy": "http://www.xe.com/privacy.php",
      "to": "USD",
      "amount": 1,
      "timestamp": "2023-07-14T00:00:00Z",
      "from": [
        {
          "quotecurrency": "SGD",
          "mid": 1.32262978
        }
      ]
    }

    $ ./xe.sh USD to SGD
    ######################################################################## 100.0%
    {
      "terms": "http://www.xe.com/legal/dfs.php",
      "privacy": "http://www.xe.com/privacy.php",
      "to": "SGD",
      "amount": 1,
      "timestamp": "2023-07-14T00:00:00Z",
      "from": [
        {
          "quotecurrency": "USD",
          "mid": 0.7560694725
        }
      ]
    }

### `xe_currency` gem

The [xe_currency](https://github.com/degica/xe_currency) gem provides a simple interface for querying current exchange rates.
It does not support access to historic rates or other api features.

The example uses the currently unpublished 0.0.2 version of the gem (installed via bundler):

    $ bundle install
    ....
    $ bundle exec ./xe_currency_example.rb USD to SGD
    0.7560694725e0
    $ bundle exec ./xe_currency_example.rb SGD to USD
    0.132262978e1

## Credits and References

* [xe_currency](https://rubygems.org/gems/xe_currency) - rubygems
* [xe_currency](https://github.com/degica/xe_currency) - github
* [Xe Currency Data](https://www.xe.com/xecurrencydata/)
* [Xe Currency Data API 1.0](https://xecdapi.xe.com/docs/v1/)
