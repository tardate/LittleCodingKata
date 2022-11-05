# Trumpeter Catalog Skin

A simple and fast offline Trumpeter model catalog skin, using some nokogiri magic.

Here's a quick demo..

[![clip](https://img.youtube.com/vi/dSDu7Qz8sBU/0.jpg)](https://www.youtube.com/watch?v=dSDu7Qz8sBU)

## Notes

> these original notes are left as-is, however I have ported this project over to
> maintain independently at <https://github.com/tardate/trumpeter_catalog>

Trumpeter 小号手公司 is one of the main scale model manufacturers in China,
and [their website](http://www.trumpeter-china.com) is not only available in English, but reasonably informative.
It is very slow however, and a pain to search.

This is a little weekend project to create a fast and searchable skin for the Trumpeter catalog.

## Setup

The catalog runs locally and needs a working ruby installation - I'm using Ruby 2.7.2 but the code is not version-sensitive.
Dependencies can be installed with bundler in the usual way, then you are good to go:

```
$ bundle install
```

## Caching the Catalog

The `./update_cache.rb` script builds a local cache of the Trumpeter catalog.
NB: this is sensitive to major changes in the Trumpeter web site, but for now works fine.

```
$ ./update_cache.rb
[Load Product Pages][2020-12-06 21:29:24 +0800] loaded
[Load Products][2020-12-06 21:29:24 +0800] loaded
[Load Product Image][2020-12-06 21:29:24 +0800] loading skin/cache/images/09592.jpg with a 1 second grace period delay
[Load Product Image][2020-12-06 21:29:24 +0800] loading skin/cache/images/09580.jpg with a 1 second grace period delay
...
```

## Running the Catalog

After updating the cache, the `skin/index.html` presents a very snappy searchable and filterable listing
of the catalog. It's a simple web page using some basic Bootstrap and Datatables features with a little custom javascript.

Here's an example, with a simple search applied.
Each entry has links to the main Trumpeter page as well as search links for the product on AliExpress and Google.

![file_example](./assets/file_example.jpg?raw=true)

Note: the catalog is loaded from JSON file, which presents a security issue if the `skin/index.html` is loaded
locally as a file in a browser.

In Firefox, the security issue can be overcome by disabling the `security.fileuri.strict_origin_policy` preference in `about:config`

## Running with Sinatra

I've defined a simple Sinatra app in `app.rb` that can be used to serve the catalog locally over HTTP,
avoiding the browser limitations with loading the JSON data file. Run it with:

```
$ ruby app.rb
== Sinatra (v2.1.0) has taken the stage on 4567 for development with backup from Thin
2020-12-06 23:31:57 +0800 Thin web server (v1.8.0 codename Possessed Pickle)
2020-12-06 23:31:57 +0800 Maximum connections set to 1024
2020-12-06 23:31:57 +0800 Listening on localhost:4567, CTRL+C to stop
::1 - - [06/Dec/2020:23:32:06 +0800] "GET / HTTP/1.1" 302 - 0.0034
::1 - - [06/Dec/2020:23:32:06 +0800] "GET /index.html HTTP/1.1" 304 - 0.0103
...
```

![sinatra_example](./assets/sinatra_example.jpg?raw=true)

## Credits and References

* [Trumpeter Main Site](http://www.trumpeter-china.com)
* [Datatables](https://datatables.net/)
* [Bootstrap](https://getbootstrap.com/docs/3.4/)
* [Sinatra Docs](http://sinatrarb.com/)
