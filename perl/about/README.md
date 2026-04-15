# #441 About Perl

An overview of the Perl programming language, its features, and ecosystem. Includes setting up and running on macOS.

## Perl In a Nutshell

Perl is:

* A high-level, general-purpose programming language created by Larry Wall in 1987
* Designed for **text processing**, **system administration**, and **scripting**, with strong roots in Unix culture
* Known for its philosophy: *“There’s more than one way to do it” (TMTOWTDI)*
* Both an **interpreted language** and a **glue language**—excellent for connecting systems and automating workflows
* Dynamically typed, with flexible syntax that allows concise but sometimes cryptic code
* Still widely used in **legacy systems**, **bioinformatics**, and **DevOps tooling**

Perl has:

* Powerful **text manipulation features**, especially via built-in **regular expressions** (one of its defining strengths)
* Multiple programming paradigms: **procedural**, **object-oriented**, and some **functional** support
* A rich standard library plus a massive external ecosystem via CPAN (tens of thousands of modules)
* Context-sensitive behavior (scalar vs list context) that influences how expressions are evaluated
* Flexible data structures: arrays, hashes (associative arrays), and references for complex structures
* Strong support for **file handling**, **process control**, and **system interaction**
* Built-in features for **one-liners** and quick scripting (commonly used in shell pipelines)
* A reputation for **readability trade-offs**—can be extremely concise but harder to maintain without discipline

Perl is governed by:

* An open-source development model led historically by Larry Wall and now by the Perl Steering Council
* A global, long-standing community centered around CPAN contributors, mailing lists, and conferences like The Perl Conference
* A culture that values **pragmatism**, **expressiveness**, and **developer freedom** over strict uniformity
* Ongoing evolution through modern versions (Perl 5.x), with improvements in performance, maintainability, and tooling
* A sixth version of Perl was in development, but it was renamed [Raku](https://en.wikipedia.org/wiki/Raku_(programming_language)) and now managed as a separate language

## Why Perl?

* **Unmatched text-processing power** — best-in-class regular expressions and string handling make it ideal for parsing logs, data munging, and report generation
* **Rapid scripting and prototyping** — minimal boilerplate, easy one-liners, and fast turnaround for small tools and automation
* **“Glue language” strength** — excels at stitching together systems, shell commands, and disparate tools
* **Huge module ecosystem** via CPAN — mature, battle-tested libraries for almost anything
* **Strong Unix integration** — natural fit for sysadmin tasks, pipelines, cron jobs, and infrastructure scripting
* **Flexibility and expressiveness** — multiple ways to solve a problem (TMTOWTDI), allowing highly concise solutions
* **Backward compatibility** — Perl code from years ago often still runs today with minimal changes
* **Good for legacy systems** — many enterprises still rely on Perl; valuable for maintenance and refactoring work
* **Solid performance for scripting tasks** — faster than many interpreted languages in text-heavy workloads
* **Mature and stable** — decades of real-world use mean fewer surprises in production
* **Niche strengths** — particularly strong in bioinformatics, log analysis, and ETL-style data processing
* **Low barrier to entry (for basics)** — simple scripts are easy to start, even if mastery takes time

## Why not Perl?

* **Readability issues** — highly expressive syntax can become cryptic (“write-only code”) without strict discipline
* **Inconsistent style** — the *TMTOWTDI* philosophy leads to many different ways to solve the same problem, making team codebases harder to standardize
* **Declining popularity** — fewer new projects and a smaller talent pool compared to languages like Python, Go, or JavaScript
* **Ecosystem aging** — while CPAN is vast, some modules are outdated or inconsistently maintained
* **Modern tooling gaps** — weaker support for IDEs, linting, formatting, and dependency management compared to newer ecosystems
* **Object-oriented complexity** — OO in Perl (especially pre-modern frameworks like Moose/Moo) can feel bolted-on and less intuitive
* **Harder onboarding** — steep learning curve for reading idiomatic code, even if writing simple scripts is easy
* **Community contraction** — smaller and aging community, fewer new learning resources and discussions
* **Competition from better-specialized tools**
    * Python for general scripting and data work
    * Go for systems and DevOps tooling
    * Rust for performance-critical work
* **Performance limits** — fine for scripting, but not ideal for CPU-intensive or large-scale concurrent systems
* **Perception problem** — often seen as “legacy tech,” which can affect hiring, long-term maintainability, and stakeholder confidence

## Running Perl on macOS

macOS ships with a system Perl (e.g. /usr/bin/perl). It is old and managed by Apple. Don’t modify it — you can break system tools.

```sh
$ which perl
/usr/bin/perl
$ perl -v

This is perl 5, version 34, subversion 1 (v5.34.1) built for darwin-thread-multi-2level
```

Installing and maintaining a newer version of Perl is best done with the [Perl homebrew formula](https://formulae.brew.sh/formula/perl):

```sh
$ brew install perl
...
By default non-brewed cpan modules are installed to the Cellar. If you wish
for your modules to persist across updates we recommend using `local::lib`.

You can set that up like this:
  PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
And add the following to your shell profile e.g. ~/.profile or ~/.zshrc
  eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

$ which perl
/opt/homebrew/bin/perl
$ perl -v

This is perl 5, version 42, subversion 2 (v5.42.2) built for darwin-thread-multi-2level
```

The brew version of Perl will be used as long as `/opt/homebrew/bin` is prefixed to the `PATH` environment variable.

Using [cpan](https://metacpan.org/pod/cpan) to install modules from [CPAN](https://www.cpan.org/):

```sh
$ cpan JSON
...
  MLEHMANN/JSON-XS-4.04.tar.gz
  /usr/bin/make install  -- OK
```

Using [cpanm](https://metacpan.org/pod/App::cpanminus) to install modules from [CPAN](https://www.cpan.org/):

```sh
$ brew install cpanminus
...
$ cpanm JSON
JSON is up to date. (4.11)
```

## A 🐪 Perl Cheat-sheet

### Basic Structure

```perl
#!/usr/bin/perl
use strict;
use warnings;

print "Hello, world\n";
```

### Variables

```perl
my $scalar = 42;          # single value
my @array  = (1, 2, 3);   # ordered list
my %hash   = (a => 1, b => 2);  # key-value pairs
```

* Sigils define type: `$` (scalar), `@` (array), `%` (hash)

### Context (Important!)

```perl
my @a = (1,2,3);
my $count = @a;   # scalar context → 3
my @copy  = @a;   # list context → (1,2,3)
```

### Control Flow

```perl
if ($x > 10) {
    print "big\n";
} elsif ($x > 5) {
    print "medium\n";
} else {
    print "small\n";
}

for my $i (1..5) {
    print "$i\n";
}

while (<STDIN>) {
    print if /error/;
}
```

### Strings & Interpolation

```perl
my $name = "Paul";
print "Hello $name\n";   # interpolates

print 'Hello $name\n';   # literal
```

### Regular Expressions (Core Strength)

```perl
$_ = "hello 123";

if (/(\d+)/) {
    print "Found number: $1\n";
}

s/hello/hi/;     # substitution
tr/a-z/A-Z/;     # transliteration
```

### Arrays & Hashes

```perl
# Arrays
push @a, 4;
pop @a;
my $first = $a[0];

# Hashes
$hash{key} = "value";
print $hash{key};

for my $k (keys %hash) {
    print "$k => $hash{$k}\n";
}
```

### Subroutines

```perl
sub add {
    my ($a, $b) = @_;
    return $a + $b;
}

print add(2, 3);
```

### File Handling

```perl
open my $fh, '<', 'file.txt' or die $!;
while (<$fh>) {
    print;
}
close $fh;
```

### One-Liners (Very Perl)

```bash
perl -ne 'print if /error/' logfile.txt
perl -pe 's/foo/bar/g' file.txt
```

### Useful Built-ins

```perl
chomp($line);     # remove newline
split /,/, $str;  # string → list
join ",", @a;     # list → string
map { $_ * 2 } @a;
grep { $_ > 10 } @a;
```

### Modules & Packages

```perl
use strict;
use warnings;
use Data::Dumper;

print Dumper(\%hash);
```

* Install from CPAN:

```bash
cpan Some::Module
```

### Object-Oriented (Minimal Example)

```perl
package MyClass;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub hello {
    print "Hello\n";
}

1;
```

### Command-Line Arguments

```perl
my @args = @ARGV;
print "First arg: $args[0]\n";
```

### Special Variables

```perl
$_    # default variable
@_    # subroutine args
$.    # line number
$!    # last error
```

## Credits and References

* <https://www.perl.org/>
* <https://www.cpan.org/>
* <https://metacpan.org/pod/cpan>
* <https://metacpan.org/pod/App::cpanminus>
* <https://en.wikipedia.org/wiki/Perl>
* <https://en.wikipedia.org/wiki/Raku_(programming_language)>
