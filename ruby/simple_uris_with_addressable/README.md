# Simple URIs with addressable

Using the addressable gem for better handling of URIs/URLs

## Notes

URI/URL handling in Ruby is usually handled by default with the [URI](https://apidock.com/ruby/URI) class from the standard library.
It suffers from a few annoyances, for example:

* a lot of legacy cruft (try finding the correct encode/escape function for a given situation!)
* does a pretty good job of decomposing URLs, but doesn't provide much help when going the other way - composing URLs from parts
* it has a very old school and un-ruby-ish API

The [addressable](https://github.com/sporkmonger/addressable) gem solves many of these problems,
and may in fact already be in your project - it's a popular dependency of many widely used gems like fog and capybara.

I'm just going to test drive a few common scenarios and compare the URI and addressable capabilities.
The [examples.rb](./examples.rb) script tests the actual code.


### URL Decomposition

The simplest task, and no surpises here. Given a URI-ish string, parse out the component parts.

The URI way:
```
uri = URI(given)
```

The addressable way:
```
uri = Addressable::URI.parse(given)
```

The main advantage of addressable here is that it provides some nice additional methods for examining the result, including:
`ip_based?`, `default_port`, `inferred_port`, `tld`, `domain`, `site`, `basename`, `extname`.

### URL Composition

Given the individual component parts (scheme, host, path etc), create a valid URI.

The URI way:
```
uri = URI.new('http', nil, 'www.example.com', nil, nil, '/foo/bar', false, nil, nil)
uri = URI::Generic.build({:scheme => 'http', :host => 'www.example.com', :path => '/foo/bar'})
uri = URI::HTTP.build({:host => 'www.example.com', :path => '/foo/bar'})
uri = URI::HTTPS.build({:host => 'www.example.com', :path => '/foo/bar'})
```

The addressable way:
```
uri = Addressable::URI.new({:scheme => 'http', :host => 'www.example.com', :path => '/foo/bar'})
```

### URI Templates

More goodness in addressable: [RFC 6570](https://www.rfc-editor.org/rfc/rfc6570.txt) URI templates.

An `Addressable::Template` defines to `expand` or `extract` the components of a URI.
This could make funky argument parsing easier if one is not working within a web framework that already provides
this capability.

### Running the Examples

See the [examples.rb](./examples.rb) script for details.

```
$ ruby examples.rb
Run options: --seed 49659

# Running:

......

Finished in 0.034040s, 235.0176 runs/s, 940.0705 assertions/s.

8 runs, 32 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [addressable](https://github.com/sporkmonger/addressable) - source
* [addressable](https://www.rubydoc.info/gems/addressable/file/README.md) - rubydoc
* [addressable](https://rubygems.org/gems/addressable/versions/2.4.0) - rubygems
* [Ruby URI](https://apidock.com/ruby/URI) - apidock
* [Ruby URI](https://docs.ruby-lang.org/en/2.1.0/URI.html) - ruby-lang
