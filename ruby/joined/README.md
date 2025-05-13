# #328 joined

Testing the joined gem, a low-dependency implementation of the Rails to_sentence method.

## Notes

The [joined](https://rubygems.org/gems/joined) gem
is a relatively new project that aims to provide the same features as the
[to_sentence](https://api.rubyonrails.org/classes/Array.html#method-i-to_sentence)
method from Rails, but without the Rails overhead.

It currently does not support `:locale` but as of version 0.2.0,
it has all the necessary options to control delimiters between words.

### Installation

Typical `gem install joined` or bundler with a [Gemfile](./Gemfile)

    $ bundle
    Fetching gem metadata from https://rubygems.org/.
    Resolving dependencies...
    Fetching joined 0.2.0
    Installing joined 0.2.0
    Bundle complete! 1 Gemfile dependency, 2 gems now installed.
    Use `bundle info [gemname]` to see where a bundled gem is installed.

## Testing Canonical Examples

The [test_joined.rb](./test_joined.rb) script exercises the gem with some typical cases:

    %w[apples oranges pears].joined
    => "apples, oranges, and pears"
    %w[apples oranges pears].joined(oxford: false)
    => "apples, oranges and pears"
    %w[apples oranges pears].joined(words_connector: ' - ')
    => "apples - oranges, and pears"
    %w[apples oranges pears].joined(last_word_connector: ', - ')
    => "apples, oranges, - pears"
    %w[apples oranges pears].joined(words_connector: ' - ', last_word_connector: ', - ', oxford: false)
    => "apples - oranges - pears"

Running tests...

    $ ./test_joined.rb
    Run options: --seed 63654

    # Running:

    .....

    Finished in 0.000252s, 19841.2700 runs/s, 19841.2700 assertions/s.

    5 runs, 5 assertions, 0 failures, 0 errors, 0 skips

## Credits and References

* <https://github.com/yegor256/joined>
* <https://rubygems.org/gems/joined>
