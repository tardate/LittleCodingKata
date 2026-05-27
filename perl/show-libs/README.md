# #457 Show Perl Libraries

All about how Perl finds library files, and a simple script to report on include paths and installed modules.

## Notes

Perl looks for library files in the paths included in the [@INC](https://perldoc.perl.org/variables/@INC) array.

In addition to default Perl library location, it [includes paths](https://perldoc.perl.org/perlfaq8#How-do-I-add-a-directory-to-my-include-path-(%40INC)-at-runtime%3F) added by:

* `PERL5LIB` environment variable
* `-Idir` command line flag
* [`lib` module](https://perldoc.perl.org/lib) code
* [`local::lib` module](https://metacpan.org/pod/local::lib) code

The [ExtUtils::Installed](https://perldoc.perl.org/ExtUtils::Installed) module
provides a standard way to find out what core and module files have been installed.

### Example Script

The [show-perl-libs.pl](./show-perl-libs.pl) script reports on include paths and installed modules.

```perl
#!/usr/bin/env perl
# Show the Perl library paths and installed modules
# Usage: show-perl-libs.pl [-v]
use ExtUtils::Installed;

my $verbose = grep { $_ eq '-v' } @ARGV;

print "PERL5LIB: ", $ENV{'PERL5LIB'};

print "\n\nLIBRARY PATH:\n";
printf "%d %s\n", $i++, $_ for @INC;

print "\nINSTALLED MODULES\n";

# find all the installed modules
my $installed = ExtUtils::Installed->new();

# list modules
foreach my $module ($installed->modules()) {
  my $version = $installed->version($module) || "???";
  print("Found module $module Version $version\n");
  if (!$verbose) {
    next;
  }
  print("  Files:\n");
  foreach my $file ($installed->files($module)) {
    print("    - $file\n");
  }
  print("  Directories:\n");
  foreach my $dir ($installed->directories($module)) {
    print("    - $dir\n");
  }
}
```

### Example Results

Running [show-perl-libs.pl](./show-perl-libs.pl):

```sh
$ ./show-perl-libs.pl
PERL5LIB:

LIBRARY PATH:
0 /opt/homebrew/opt/perl/lib/perl5/site_perl/5.42/darwin-thread-multi-2level
1 /opt/homebrew/opt/perl/lib/perl5/site_perl/5.42
2 /opt/homebrew/lib/perl5/vendor_perl/5.42/darwin-thread-multi-2level
3 /opt/homebrew/lib/perl5/vendor_perl/5.42
4 /opt/homebrew/opt/perl/lib/perl5/5.42/darwin-thread-multi-2level
5 /opt/homebrew/opt/perl/lib/perl5/5.42
6 /opt/homebrew/lib/perl5/site_perl/5.42

INSTALLED MODULES
Found module Canary::Stability Version 2013
Found module JSON Version 4.11
Found module JSON::XS Version 4.04
Found module Perl Version 5.42.2
Found module Sub::Uplevel Version 0.2800
Found module Test::Simple Version 1.302219
Found module Test::Warn Version 0.37
Found module Types::Serialiser Version 1.01
Found module common::sense Version 3.75
```

If given a `-v` parameter, it will print verbose results (with all file and folder details), e.g. `./show-perl-libs.pl -v > verbose-output.txt`

A truncated example of [verbose-output.txt](./verbose-output.txt) is as follows:

```txt
PERL5LIB:

LIBRARY PATH:
0 /opt/homebrew/opt/perl/lib/perl5/site_perl/5.42/darwin-thread-multi-2level
1 /opt/homebrew/opt/perl/lib/perl5/site_perl/5.42
2 /opt/homebrew/lib/perl5/vendor_perl/5.42/darwin-thread-multi-2level
3 /opt/homebrew/lib/perl5/vendor_perl/5.42
4 /opt/homebrew/opt/perl/lib/perl5/5.42/darwin-thread-multi-2level
5 /opt/homebrew/opt/perl/lib/perl5/5.42
6 /opt/homebrew/lib/perl5/site_perl/5.42

INSTALLED MODULES
Found module Canary::Stability Version 2013
  Files:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Canary/Stability.pm
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3/Canary::Stability.3
  Directories:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Canary
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3
Found module JSON Version 4.11
  Files:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/JSON/backportPP/Compat5005.pm
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/JSON/backportPP/Boolean.pm
    ...
  Directories:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/JSON
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/JSON/backportPP
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3
Found module JSON::XS Version 4.04
  Files:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/darwin-thread-multi-2level/JSON/XS/Boolean.pm
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/darwin-thread-multi-2level/JSON/XS.pm
    ...
  Directories:
    - /opt/homebrew/Cellar/perl/5.42.2/bin
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/darwin-thread-multi-2level/JSON
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/darwin-thread-multi-2level/JSON/XS
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/darwin-thread-multi-2level/auto/JSON/XS
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man1
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3
Found module Perl Version 5.42.2
  Files:
  Directories:
Found module Sub::Uplevel Version 0.2800
  Files:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Sub/Uplevel.pm
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3/Sub::Uplevel.3
  Directories:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Sub
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3
Found module Test::Simple Version 1.302219
  Files:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Test/Tutorial.pod
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3/Test2::EventFacet::Render.3
    ...
  Directories:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Test
    ...
Found module Test::Warn Version 0.37
  Files:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Test/Warn.pm
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3/Test::Warn.3
  Directories:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Test
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3
Found module Types::Serialiser Version 1.01
  Files:
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3/Types::Serialiser::Error.3
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3/Types::Serialiser.3
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Types/Serialiser.pm
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Types/Serialiser/Error.pm
  Directories:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Types
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/Types/Serialiser
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3
Found module common::sense Version 3.75
  Files:
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3/common::sense.3
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/darwin-thread-multi-2level/common/sense.pm
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/darwin-thread-multi-2level/common/sense.pod
  Directories:
    - /opt/homebrew/Cellar/perl/5.42.2/lib/perl5/site_perl/5.42/darwin-thread-multi-2level/common
    - /opt/homebrew/Cellar/perl/5.42.2/share/man/man3
```

## Credits and References

* [@INC](https://perldoc.perl.org/variables/@INC)
* ["How do I add a directory to my include path (@INC) at runtime?"](https://perldoc.perl.org/perlfaq8#How-do-I-add-a-directory-to-my-include-path-(%40INC)-at-runtime%3F)
* [`lib` module](https://perldoc.perl.org/lib)
* [`local::lib` module](https://metacpan.org/pod/local::lib)
* [ExtUtils::Installed](https://perldoc.perl.org/ExtUtils::Installed)
