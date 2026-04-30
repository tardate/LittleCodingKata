# #xxx Carp

About using the Carp module for error handling in Perl

## Notes

The [Carp (Perl module)](https://perldoc.perl.org/Carp) is Perl’s standard error-reporting helper that improves on plain `warn()` and `die()` by reporting problems from the caller’s perspective rather than where the error occurred internally. It’s mainly used in modules so that users see errors as if they originated in their own code, not deep inside library internals.

Key functions:

* `carp` – like `warn`, but reports the error at the caller’s location (short message, minimal stack)
* `croak` – like `die`, but reported at the caller’s location (short message, minimal stack)
* `cluck` – like `carp`, but includes a full stack trace
* `confess` – like `croak`, but with a full stack trace

## Demonstration

The [examples.sh](./examples.sh) script
calls all the demonstrations supported by the [example.pl](./example.pl) Perl script and reports the exit code:

```sh
$ ./examples.sh
Running carp examples...

## Demonstrating: carp
This is a warning message. (carp: warning message from perspective of caller) at example.pl line 66.
shortmess: at example.pl line 66.
longmess: at example.pl line 41.
        Demo::demoCarpModule("carp") called at example.pl line 66
Exit code: 0

## Demonstrating: cluck
This is a warning message with stack trace. (cluck: like carp but with stack trace) at example.pl line 22.
        Demo::demoCluck() called at example.pl line 41
        Demo::demoCarpModule("cluck") called at example.pl line 66
shortmess: at example.pl line 66.
longmess: at example.pl line 41.
        Demo::demoCarpModule("cluck") called at example.pl line 66
Exit code: 0

## Demonstrating: croak
This is an error message. (croak: error message from perspective of caller) at example.pl line 66.
Exit code: 255

## Demonstrating: confess
This is an error message. (confess: like croak but with stack trace) at example.pl line 32.
        Demo::demoConfess() called at example.pl line 41
        Demo::demoCarpModule("confess") called at example.pl line 66
Exit code: 255

## Demonstrating: read-file-ok
text file content
Exit code: 0

## Demonstrating: read-file-bad
Cannot locate file! at example.pl line 66.
Exit code: 2

## Demonstrating: settings
Carp settings:
  Carp::MaxEvalLen: 0
  Carp::MaxArgLen: 64
  Carp::MaxArgNums: 8
  Carp::Verbose: 0
Exit code: 0
```

## Example Code

The [example.pl](./example.pl) Perl script:

```perl
#!/usr/bin/env perl
#
package Demo;
use Carp;
use Carp qw(cluck longmess shortmess);

sub readFile {
 my $filename = shift(@_);
 open(FILE, $filename) or croak("Cannot locate file!");
 print <FILE>;
 close FILE;
}

sub demoCarp {
  carp "This is a warning message. (carp: warning message from perspective of caller)";
  print shortmess("shortmess:");
  print longmess("longmess:");
}

sub demoCluck {
  cluck "This is a warning message with stack trace. (cluck: like carp but with stack trace)";
  print shortmess("shortmess:");
  print longmess("longmess:");
}

sub demoCroak {
  croak "This is an error message. (croak: error message from perspective of caller)";
}

sub demoConfess {
  confess "This is an error message. (confess: like croak but with stack trace)";
}

sub demoCarpModule {
  my $method = shift(@_);

  print "\n## Demonstrating: $method\n";

  if ($method eq 'carp') {
    demoCarp();
  } elsif ($method eq 'croak') {
    demoCroak();
  } elsif ($method eq 'cluck') {
    demoCluck();
  } elsif ($method eq 'confess') {
    demoConfess();
  } elsif ($method eq 'read-file-ok') {
    readFile('data.txt');
  } elsif ($method eq 'read-file-bad') {
    readFile('data.txt.missing');
  } elsif ($method eq 'settings') {
    print "Carp settings:\n";
    print "  Carp::MaxEvalLen: ", $Carp::MaxEvalLen, "\n";
    print "  Carp::MaxArgLen: ", $Carp::MaxArgLen, "\n";
    print "  Carp::MaxArgNums: ", $Carp::MaxArgNums, "\n";
    print "  Carp::Verbose: ", $Carp::Verbose, "\n";
  } else {
    print "Unknown argument. Use 'carp', 'croak', 'confess', 'cluck', 'read-file-ok', 'read-file-bad', or 'settings'.\n";
  }
}

package main;
my $arg = shift(@ARGV) // 'carp';
Demo::demoCarpModule($arg);

1;
```

The [example.sh](./examples.sh) script is a wrapper to call all the examples and report the process exit code:

```bash
#!/usr/bin/env bash

function runExample() {
  local method="$1"
  perl example.pl "$method"
  local rc=$?
  echo "Exit code: $rc"
}

echo "Running carp examples..."
runExample "carp"
runExample "cluck"
runExample "croak"
runExample "confess"
runExample "read-file-ok"
runExample "read-file-bad"
runExample "settings"

```

## The Difference Between `carp` and `cluck`

The `cluck` method is like `carp` but with full stack trace.

But consider the following example [carp-cluck-a.pl](./carp-cluck-a.pl):

```perl
#!/usr/bin/env perl
#
use Carp qw(carp cluck);

sub c {
    carp "carp";
    cluck "cluck";
}
sub a { b() }
sub b { c() }

a();
```

It shows `carp` and `cluck` essentially behaving identically:

```sh
$ ./carp-cluck-a.pl
carp at ./carp-cluck-a.pl line 6.
        main::c() called at ./carp-cluck-a.pl line 10
        main::b() called at ./carp-cluck-a.pl line 9
        main::a() called at ./carp-cluck-a.pl line 12
cluck at ./carp-cluck-a.pl line 7.
        main::c() called at ./carp-cluck-a.pl line 10
        main::b() called at ./carp-cluck-a.pl line 9
        main::a() called at ./carp-cluck-a.pl line 12
```

This is because while `carp` tries to stop at the first "external" caller, but in simple or single-package call stacks it may include as many frames as `cluck`.
Older versions of Carp were more aggressive about stopping early, but this is the modern behaviour (I am using v5.42.2).

If we modify the example to make the calls across module boundaries per [carp-cluck-b.pl](./carp-cluck-b.pl):

```perl
#!/usr/bin/env perl
#
package My::Layer;
use Carp qw(carp cluck);
sub c {
    carp "carp";
    cluck "cluck";
}

package main;
sub a { b() }
sub b { My::Layer::c() }

a();
```

Now we see distinct behaviour:

```sh
$ ./carp-cluck-b.pl
carp at ./carp-cluck-b.pl line 12.
cluck at ./carp-cluck-b.pl line 7.
        My::Layer::c() called at ./carp-cluck-b.pl line 12
        main::b() called at ./carp-cluck-b.pl line 11
        main::a() called at ./carp-cluck-b.pl line 14
```

## Credits and References

* <https://perldoc.perl.org/Carp>
* <https://github.com/Perl/perl5/blob/blead/dist/Carp/lib/Carp.pm>
* ["Should I use carp/croak or warn/die"](https://www.perlmonks.org/?node_id=1215465)
* ["Carping About DBI" (via archive.org)](https://web.archive.org/web/20171014032430/http://www.devshed.com/c/a/Perl/Carping-About-DBI/)
