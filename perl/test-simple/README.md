# #454 Test::Simple

The basics of Perl testing with the Test::Simple module.

## Notes

The Perl [Test::Simple](https://perldoc.perl.org/Test::Simple)
module is an extremely simple, extremely basic module for writing tests for Perl projects and modules.

See also: [Perl Testing](../../books/perl-testing/) - Chapter 1. Beginning Testing.

Module installation:

```sh
$ cpan Test::Simple
Loading internal logger. Log::Log4perl recommended for better logging
Reading '/Users/paulgallagher/.cpan/Metadata'
  Database was generated on Fri, 08 May 2026 02:17:02 GMT
Test::Simple is up to date (1.302219).
```

## A Basic Test File

Given a simple script [hello.pl](./hello.pl):

```perl
#!/usr/bin/env perl
#
use strict;
use warnings;

sub hello_world {
  return "Hello, World!";
}

print hello_world(), "\n" if !caller();

1;
```

When run interactively, it simply prints the result of the `hello_world` function:

```sh
$ ./hello.pl
Hello, World!
```

Let's write some tests in [hello.t](./hello.t):

```perl
#!/usr/bin/env perl
#
use strict;
use warnings;

use lib ".";
require 'hello.pl';

use Test::Simple tests => 1;

ok( hello_world() eq "Hello, World!", 'hello_world output should be sane');
```

NB: if we don't know or care how many tests to expect, can declare with no plan: `use Test::Simple 'no_plan';`

Tests are run with `prove`:

```sh
$ prove hello.t
hello.t .. ok
All tests successful.
Files=1, Tests=1,  0 wallclock secs ( 0.01 usr  0.01 sys +  0.01 cusr  0.00 csys =  0.03 CPU)
Result: PASS
$ prove -v hello.t
hello.t ..
1..1
ok 1 - hello_world output should be sane
ok
All tests successful.
Files=1, Tests=1,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.01 cusr  0.00 csys =  0.02 CPU)
Result: PASS
```

## Credits and References

* <https://perldoc.perl.org/Test::Simple>
* [Perl Testing](../../books/perl-testing/) - Chapter 1. Beginning Testing
