# #093 2.7 New Features

Investigating new features in Ruby 2.7.0, released 2019-12-25

## Notes

### Install with RVM

After updating rvm, "ruby-2.7.0" is available for installation.
NB: `.ruby-version` and `.ruby-gemset` in this folder are setup to isolate an Ruby 2.7 environment.

```
$ rvm get stable
$ rvm install "ruby-2.7.0"
```

### Syntax Changes

[test_syntax_changes.rb](./test_syntax_changes.rb) tests a few
[new syntax changes](https://rubyreferences.github.io/rubychanges/2.7.html#other-syntax-changes):

* comments allowed between dotted call chains
* rescue with mutilple assignment
* beginless ranges

```
$ ./test_syntax_changes.rb
...
4 runs, 10 assertions, 0 failures, 0 errors, 0 skips
```

### Enumerables and Collections

[test_enumerables.rb](./test_enumerables.rb) tests a few
[Enumerables and Collections new features](https://rubyreferences.github.io/rubychanges/2.7.html#enumerables-and-collections):

* filter_map
* tally

```
$ ./test_enumerables.rb
...
3 runs, 3 assertions, 0 failures, 0 errors, 0 skips
```

### Numbered Block Parameters

[test_numbered_parameters.rb](./test_numbered_parameters.rb) tests the
[numbered block parameter new feature](https://rubyreferences.github.io/rubychanges/2.7.html#numbered-block-parameters):

> In block without explicitly specified parameters, variables _1 through _9 can be used to reference parameters.

```
$ ./test_numbered_parameters.rb
...
4 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```

### Keyword argument-related changes

[test_keyword_args.rb](./test_keyword_args.rb) tests
[Keyword argument-related changes](https://rubyreferences.github.io/rubychanges/2.7.html#keyword-argument-related-changes)

* Argument forwarding

```
$ ./test_keyword_args.rb
...
2 runs, 6 assertions, 0 failures, 0 errors, 0 skips
```

### Pattern matching

[test_pattern_matching.rb](./test_pattern_matching.rb) tests the
[new and experimental pattern matching feature](https://rubyreferences.github.io/rubychanges/2.7.html#pattern-matching)

```
$ ./test_pattern_matching.rb
...
2 runs, 6 assertions, 0 failures, 0 errors, 0 skips
```


## Credits and References

* [RVM](https://rvm.io/)
* [Ruby 2.7 changelog](https://rubyreferences.github.io/rubychanges//2.7.html)
* [All(most all) you need to know about Ruby 2.7](https://prathamesh.tech/2019/12/25/all-you-need-to-know-about-ruby-2-7/)
