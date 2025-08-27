# #270 Using with_defaults

About the `reverse_merge` and `with_defaults` Hash mixins from Rails

## Notes

A great little article from Andy Croll:
[For clarity merging hashes use with_defaults](https://andycroll.com/ruby/with_defaults-clarity-when-merging-hashes/)

I've used `reverse_merge` quite a bit, but the semantics of `with_defaults` are very nice IMHO.

    params = { a: 'value of a', b: 'value of b' }
    defaults = { a: 'default value of a', b: 'default value of b', c: 'default value of c' }
    params.with_defaults(defaults)
    => { a: 'value of a', b: 'value of b', c: 'default value of c' }

These function as are available if running Rails.
To use in other ruby projects, add 'activesupport' gem to your project
and require core activesupport:

    require 'active_support'
    require 'active_support/core_ext'

## Example Test

See a simple test in [test_with_defaults.rb](./test_with_defaults.rb):

    $ ./test_with_defaults.rb
    Run options: --seed 24687

    # Running:

    .

    Finished in 0.001573s, 635.7279 runs/s, 635.7279 assertions/s.

    1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

## Credits and References

* [For clarity merging hashes use with_defaults](https://andycroll.com/ruby/with_defaults-clarity-when-merging-hashes/)
