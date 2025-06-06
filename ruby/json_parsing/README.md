# #044 JSON Parsing

Generating pretty JSON with Ruby and dealing with quirks.

## Notes

Ruby's support for JSON is implemented as a core but separate [json gem](https://github.com/flori/json).
This is a implementation of the JSON specification according to [RFC 4627](https://www.ietf.org/rfc/rfc4627.txt).

There are perhaps four main methods most commonly used form the JSON library:

* For serialializing an object to JSON:
  * `to_json` instance method available for all supported classes
  * `JSON.pretty_generate` class method generates a more human-readable JSON representation
* For deserializing JSON:
  * `JSON.load` - given a string or stream
  * `JSON.parse` - given a string

Note: this is only an issue with ruby <= 2.3 (I think) as later rubies require a later json gem version anyway.

### `pretty_generate` Verson-dependent Behaviour

Prior to v2.0.0 -
actually before [this commit](https://github.com/flori/json/commit/4b843b585060212e8c396073f79627bf081491db#diff-c396b704e4eb30dedc22d380848c050d)
- the `pretty_generate` method only worked with arrays and hashes.
Attempting to prettify any other type of object would result in an exception: `JSON::GeneratorError: only generation of JSON objects or arrays allowed`.

This can be an upgrade gotcha, as early code may for example have been written to expect nil to raise an exception. After json gem upgrade, code paths will change.

The [test_pretty_generate.rb](./test_pretty_generate.rb) script tests some of this version-dependent behaviour.
The [test.sh](./test.sh) shell script runs the tests with different versions of the json gem:


```
$ ./test.sh
ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin17]
Gem 'json' is not installed

*** LOCAL GEMS ***

json (default: 1.8.3)


*** RUNNING TESTS WITH JSON v1.8.3 ***

Run options: --seed 7402

# Running:

....

Finished in 0.002317s, 1726.3703 runs/s, 1726.3703 assertions/s.

4 runs, 4 assertions, 0 failures, 0 errors, 0 skips
Fetching json-2.1.0.gem
Building native extensions. This could take a while...
Successfully installed json-2.1.0
Parsing documentation for json-2.1.0
Installing ri documentation for json-2.1.0
Done installing documentation for json after 1 seconds
1 gem installed

*** LOCAL GEMS ***

json (2.1.0, default: 1.8.3)


*** RUNNING TESTS WITH JSON v2.1.0 ***

Run options: --seed 24841

# Running:

....

Finished in 0.001192s, 3355.7047 runs/s, 3355.7047 assertions/s.

4 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [JSON implementation for Ruby](https://github.com/flori/json) - GitHub source
* [json](https://rubygems.org/gems/json) - rubygems
* [RFC 4627](https://www.ietf.org/rfc/rfc4627.txt)
