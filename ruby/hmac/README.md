# #070 HMAC Generation with Ruby

All about hash-based message authentication code (HMAC) generation with Ruby.

## Notes

Hash-based message authentication code (HMAC) is a technique for verifying the data integrity and the authentication of a message.
As specified in [rfc2104](https://tools.ietf.org/html/rfc2104), it describes the algorithm for generating a hash,
but does not specify the hashing function. The hashing function can be selected to suit the purpose, from older, weaker, functions
such as MD5 to more modern SHA256 and others.

In Ruby, HMAC generation is typically done with the Ruby OpenSSL standard library, which includes HMAC functions.
It is a wrapper library - the underlying implementation is provided by openssl.


## Example Code

The [hmac.rb](./hmac.rb) provides a trivial example of returning the hex-encoded digest with an arbitrary hashing function.
It can be used form the command line thus:

    $ ./hmac.rb md5 "key" "The quick brown fox jumps over the lazy dog"
    80070713463e7749b90c2dc24911e275

This only scratches the surface of what is possible with the
[OpenSSL::HMAC](https://ruby-doc.org/stdlib-2.1.0/libdoc/openssl/rdoc/OpenSSL/HMAC.html) library.

## Testing Canonical HMAC Examples

The [test_hmac.rb](./test_hmac.rb) wraps `hmac.rb` with some test cases for the canonical brown fox examples:

    HMAC_MD5("key", "The quick brown fox jumps over the lazy dog")    = 80070713463e7749b90c2dc24911e275
    HMAC_SHA1("key", "The quick brown fox jumps over the lazy dog")   = de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9
    HMAC_SHA256("key", "The quick brown fox jumps over the lazy dog") = f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8

Running tests...

    $ ./test_hmac.rb
    Run options: --seed 49256

    # Running:

    ...

    Finished in 0.000984s, 3049.9422 runs/s, 3049.9422 assertions/s.

    3 runs, 3 assertions, 0 failures, 0 errors, 0 skips

## Credits and References
* [HMAC](https://en.wikipedia.org/wiki/HMAC) - wikipedia
* [rfc2104 HMAC: Keyed-Hashing for Message Authentication](https://tools.ietf.org/html/rfc2104)
* [OpenSSL::HMAC](https://ruby-doc.org/stdlib-2.1.0/libdoc/openssl/rdoc/OpenSSL/HMAC.html)
