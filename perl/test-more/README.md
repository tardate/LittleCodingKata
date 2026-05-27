# #xxx Test::More

The basics of Perl testing with the Test::More module.

## Notes

[Test::More](https://perldoc.perl.org/Test::More) is the standard Perl module for writing test scripts. It provides a wide array of utilities to verify code behavior and output diagnostic information in the Test Anything Protocol (TAP) format.

Test::More is a direct upgrade to Test::Simple. They both output the same Test Anything Protocol (TAP) format, but Test::More provides significantly better tools for debugging. See also: [LCK#454 Test::Simple](../test-simple/)

### Core Features

* Simple Assertions: basic checks like `ok($condition, $name)` for truthiness and `is($got, $expected, $name)` for equality.
* Deep Comparison: `is_deeply($got, $expected, $name)` tests complex, nested data structures (like arrays of hashes).
* Planning: declare how many tests expected to run with `tests => $n` or use `done_testing()` at the end of the script to ensure a test didn't exit prematurely.
* Diagnostics: When a test fails, `Test::More` automatically prints "got" and "expected" values to help debugging.
* Todo & Skip: mark tests as TODO for features not yet implemented or SKIP if certain requirements (like a specific OS or database) aren't met.

### Module installation

```sh
$ cpan Test::More
Loading internal logger. Log::Log4perl recommended for better logging
Reading '/Users/paulgallagher/.cpan/Metadata'
  Database was generated on Wed, 27 May 2026 07:54:20 GMT
Test::More is up to date (1.302219).
```

### A Basic Test File

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

use Test::More tests => 1;

is(hello_world(), 'Hello, World!', 'hello_world output should be sane');
```

NB: if we don't know or care how many tests to expect, can declare with no plan: `use Test::Simple 'no_plan';`

Tests are run with `prove`:

```sh
$ prove hello.t
hello.t .. ok
All tests successful.
Files=1, Tests=1,  0 wallclock secs ( 0.00 usr  0.00 sys +  0.01 cusr  0.00 csys =  0.01 CPU)
Result: PASS
$ prove -v hello.t
hello.t ..
1..1
ok 1 - hello_world output should be sane
ok
All tests successful.
Files=1, Tests=1,  0 wallclock secs ( 0.01 usr  0.01 sys +  0.01 cusr  0.00 csys =  0.03 CPU)
Result: PASS
```

### Too Few Tests

The script [too_few_tests.t](too_few_tests.t) demonstrates what happens if the test plan is not met.

```perl
use Test::More tests => 3;

pass( 'one test' );
pass( 'two tests' );
```

When executed:

```sh
$ prove too_few_tests.t
too_few_tests.t .. 1/3 # Looks like you planned 3 tests but ran 2.
too_few_tests.t .. Dubious, test returned 255 (wstat 65280, 0xff00)
Failed 1/3 subtests

Test Summary Report
-------------------
too_few_tests.t (Wstat: 65280 (exited 255) Tests: 2 Failed: 0)
  Non-zero exit status: 255
  Parse errors: Bad plan.  You planned 3 tests but ran 2.
Files=1, Tests=2,  0 wallclock secs ( 0.00 usr  0.00 sys +  0.01 cusr  0.00 csys =  0.01 CPU)
Result: FAIL
```

### Testing Warnings

[Test::Warn](https://metacpan.org/pod/Test::Warn)
extension to test methods for warnings.

Installation:

```sh
$ cpan Test::Warn
Loading internal logger. Log::Log4perl recommended for better logging
Reading '/Users/paulgallagher/.cpan/Metadata'
  Database was generated on Wed, 27 May 2026 07:54:20 GMT
Test::Warn is up to date (0.37).
```

The script [warnings.t](./warnings.t) is a simple demonstration of how to assert that certain warnings are raised in tests.

```perl
use Test::More tests => 4;
use Test::Warn;

sub add_positives
{
    my ( $l, $r ) = @_;
    warn "first argument ($l) was negative"  if $l < 0;
    warn "second argument ($r) was negative" if $r < 0;
    return $l + $r;
}

warning_like { is( add_positives( 8, -3 ), 5 ) } qr/negative/;

warnings_like { is( add_positives( -8, -3 ), -11 ) }
    [ qr/first.*negative/, qr/second.*negative/ ];
```

When executed:

```sh
$ prove warnings.t
warnings.t .. ok
All tests successful.
Files=1, Tests=4,  0 wallclock secs ( 0.00 usr  0.01 sys +  0.01 cusr  0.00 csys =  0.02 CPU)
Result: PASS
```

### Testing Exceptions

[Test::Exception](https://metacpan.org/pod/Test::Exception)
is a popular Perl module used to test if your code throws (or doesn't throw) exceptions. It works alongside Test::More and provides specific functions to handle `die()` or other fatal errors during testing.

[Exception::Class](https://metacpan.org/pod/Exception::Class) provides object-oriented exception handling, along with a convenient syntax for declaring hierarchies for them.
It is a modern improvement to the old
[Error](https://metacpan.org/pod/Error)
module that is no longer recommended.

Installation:

```sh
$ cpan Test::Exception Exception::Class
Loading internal logger. Log::Log4perl recommended for better logging
Reading '/Users/paulgallagher/.cpan/Metadata'
  Database was generated on Wed, 27 May 2026 07:54:20 GMT
Test::Exception is up to date (0.43).
Exception::Class is up to date (1.45).
```

The script [exceptions.t](./exceptions.t) is a simple demonstration of how to assert that certain exceptions are raised in tests.

```perl
use Test::More tests => 3;
use Test::Exception;
use Exception::Class (
    'MyException' => { description => 'My custom exception' }
);

sub add_positives
{
    my ($l, $r) = @_;
    throw MyException("first argument ($l) was negative")  if $l < 0;
    throw MyException("second argument ($r) was negative") if $r < 0;
    return $l + $r;
}

throws_ok { add_positives( -7,  6 ) } 'MyException';
throws_ok { add_positives(  3, -9 ) } 'MyException';
throws_ok { add_positives( -5, -1 ) } 'MyException';
```

When executed:

```sh
$ prove exceptions.t
exceptions.t .. ok
All tests successful.
Files=1, Tests=3,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.01 cusr  0.00 csys =  0.02 CPU)
Result: PASS
```

## Credits and References

* <https://en.wikipedia.org/wiki/Test::More>
* <https://perldoc.perl.org/Test::More>

* ["Moving over to Test::More"](https://perlmaven.com/moving-over-to-test-more)
* [Test::Exception](https://metacpan.org/pod/Test::Exception)
* [Exception::Class](https://metacpan.org/pod/Exception::Class)
* ["Testing for exceptions with Test::More"](https://perlmonks.org/?node_id=921333)
* [Perl Testing](../../books/perl-testing/) - Chapter 2 - Writing Tests
* [LCK#454 Test::Simple](../test-simple/)
