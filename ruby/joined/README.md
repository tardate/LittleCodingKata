# #xxx joined

Testing the joined gem, a low-dependency implementation of the Rails to_sentence method.

## Notes

The [joined](https://rubygems.org/gems/joined) gem
is a relatively new project that aims to provide the same features as the
[to_sentence](https://api.rubyonrails.org/classes/Array.html#method-i-to_sentence)
method from Rails, but without the Rails overhead.

It currently does not support all the options from `to_sentence`
(`:words_connector`, `:last_word_connector`, `:two_words_connector`, or `:locale`),
but it does have a new `:oxford` option.

### Installation

Typical `gem install joined` or bundler with a [Gemfile](./Gemfile)

    $ bundle
    Fetching gem metadata from https://rubygems.org/.
    Resolving dependencies...
    Fetching joined 0.1.0
    Installing joined 0.1.0
    Bundle complete! 1 Gemfile dependency, 2 gems now installed.
    Use `bundle info [gemname]` to see where a bundled gem is installed.

## Testing Canonical Examples

The [test_joined.rb](./test_joined.rb) script exercises the gem with some typical cases:

    %w[apples oranges pears].joined
    => "apples, oranges, and pears"
    %w[apples oranges pears].joined(oxford: false)
    => "apples, oranges and pears"

Running tests...

    $ ./test_joined.rb
    Run options: --seed 20311

    # Running:

    ..

    Finished in 0.000239s, 8368.2008 runs/s, 8368.2008 assertions/s.

    2 runs, 2 assertions, 0 failures, 0 errors, 0 skips

## Credits and References

* <https://github.com/yegor256/joined>
* <https://rubygems.org/gems/joined>
