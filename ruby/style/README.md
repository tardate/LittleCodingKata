# #160 Ruby Style

On style guides and resources for ruby.

## Notes

Rubocop finally made it to [1.0 in Oct 2020](https://metaredux.com/posts/2020/10/21/rubocop-1-0.html) after 7+ years on the scene.

RuboCop is a Ruby static code analyzer (a.k.a. linter) and code formatter.
Out of the box it will enforce many of the guidelines outlined in the community [Ruby Style Guide](https://rubystyle.guide/).
(in fact, the RuboCop project is one of the major forces that brought about the style guide in the first place)

After installation, rubocop will evaluate all ruby files under the current directory by default:

    $ rubocop

Usually, rubocop is used as part of a continuous integration workflow (to make the build go red on failures).

But lets not get too obsessed by the tools. While rubocop is great, for the most part it will be something one never needs to think
about - it will jut be quietly keeping guard during builds.

However, the [Ruby Style Guide](https://rubystyle.guide/) is well worth diving into every so often, as it is a great way to
learn about using the ruby language well.

## The basic instllation and setup recipe

Add to the Gemfile

    gem 'rubocop', require: false

Automatically generate an initial config:

    $ rubocop --auto-gen-config

## Updating Rubocop

Rubocop updates can bring some major changes to rules and be a bit of a pain to deal with.

Updating .rubocop.yml to latest version can be automated with [mry](https://github.com/pocke/mry).


    $ gem install mry
    # Update to latest version
    $ mry .rubocop.yml
    # Update to specified version
    $ mry --target=0.48.0 .rubocop.yml

## Credits and References

* [The Ruby Style Guide](https://rubystyle.guide/)
* [RuboCop 1.0](https://metaredux.com/posts/2020/10/21/rubocop-1-0.html) - announcement
* [rubocop](https://github.com/rubocop/rubocop) - github
* [rubocop docs](https://docs.rubocop.org/)
* [CODING STYLE GUIDES](https://awesome-ruby.com/#-coding-style-guides) - more resources listed at awesome-ruby.com
