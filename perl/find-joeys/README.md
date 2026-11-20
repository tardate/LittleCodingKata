# #496 findJoeys

Using perl to find synonyms hiding within their alter ego: cassidoo's interview question of the week (2026-11-16).

## Notes

The [interview question of the week (2026-11-16)](https://cassidoo.co/newsletter/2026-11-15/):

> A kangaroo word contains a shorter synonym (its “joey”) whose letters appear in order, but not necessarily consecutively. Given a lowercase word and a list of its synonyms (non-empty), return all the joeys in the list’s original order. The synonyms are provided, you don’t need to determine whether two words mean the same thing. Unless you really want to.
>
> Examples:
>
> ```ts
> findJoeys("blossom", ["flower", "bloom"]);
> // ["bloom"]
>
> findJoeys("chocolate", ["cocoa", "candy"]);
> // ["cocoa"]
>
> findJoeys("cat", ["feline"]);
> // []
> ```

### Thinking about the Problem

My first thought is to recall the translate function that is supported in many languages such as Perl, Python, and Ruby.
It basically allows mapping of selected characters, and removal of anything that does not map.

So if we map the source word using the synonym as the translation map, and the resulting string matches the synonym ... we have found it hiding in the source word.

Strictly speaking, the practical way to do this in most languages is to map every character that is not in the synonym to "".
For example in Perl:

```sh
$ perl -e 'my $text = "blossom"; $text =~ tr/flower//cd; print $text . "\n";'
loo
$ perl -e 'my $text = "blossom"; $text =~ tr/bloom//cd; print $text . "\n";'
bloom
```

Or Ruby:

```sh
$ ruby -e 'puts "blossom".tr("^flower", "")'
loo
$ ruby -e 'puts "blossom".tr("^bloom", "")'
bloom

```

### Initial Solution

Let's do this with Perl's [Transliteration Quote-Like Operators](https://perldoc.perl.org/perlop#Transliteration-Quote-Like-Operators).

The main thing to note is that `tr` compiles the translation,
so we need to use an `eval` to prepare the translation at runtime.
e.g. `isWithin` checks if the synonym is found in the given word:

```perl
sub isWithin {
  my ($word, $synonym) = @_;
  eval "\$word =~ tr/\Q$synonym\E//cd";
  die $@ if $@;
  return $word eq $synonym ? 1 : 0;
}
```

We can now write `findJoeys` as just a loop, accumulating any synonyms that are found within the source word:

```perl
sub findJoeys {
  my ($word, $synonyms) = @_;
  my @results = ();
  foreach my $synonym (@$synonyms) {
    if (isWithin($word, $synonym)) {
      push @results, $synonym;
    }
  }
  return @results;
}
```

And that seems to work pretty well:

```sh
$ ./challenge.pl
Usage: perl challenge.pl <word> <csv-synonyms>
$ ./challenge.pl "blossom" "flower, bloom"
# given word=blossom, synonyms=[flower, bloom], result is:
[bloom]
$ ./challenge.pl "chocolate" "cocoa, candy"
# given word=chocolate, synonyms=[cocoa, candy], result is:
[cocoa]
$ ./challenge.pl "cat" "feline"
# given word=cat, synonyms=[feline], result is:
[]
```

### Tests

I've setup some validation in [challenge.t](./challenge.t):

```sh
$ prove -t challenge.t
challenge.t .. ok
All tests successful.
Files=1, Tests=5,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.01 cusr  0.00 csys =  0.02 CPU)
Result: PASS
```

### Final Code

See [challenge.pl](./challenge.pl) for the final code.

```perl
#!/usr/bin/env perl
#
use strict;
use warnings;

sub isWithin {
  my ($word, $synonym) = @_;
  eval "\$word =~ tr/\Q$synonym\E//cd";
  die $@ if $@;
  return $word eq $synonym ? 1 : 0;
}

sub findJoeys {
  my ($word, $synonyms) = @_;
  my @results = ();
  foreach my $synonym (@$synonyms) {
    if (isWithin($word, $synonym)) {
      push @results, $synonym;
    }
  }
  return @results;
}

if (!caller()) {
  if (@ARGV != 2) {
    print STDERR "Usage: perl challenge.pl <word> <csv-synonyms>\n";
    exit 1;
  }
  my $word = $ARGV[0];
  my @synonyms = map { s/^\s+|\s+$//g; $_ } split(',', $ARGV[1]);

  print STDERR "# given word=$word, synonyms=[" . join(', ', @synonyms) . "], result is:\n";

  my @result = findJoeys($word, \@synonyms);
  print "[" . join(', ', @result) . "]\n";
}

1;
```

## Credits and References

* [cassidoo's interview question of the week (2026-11-16)](https://cassidoo.co/newsletter/2026-11-15/)
* [Perl Transliteration Quote-Like Operators](https://perldoc.perl.org/perlop#Transliteration-Quote-Like-Operators)
* [Ruby String#tr method](https://ruby-doc.org/core-3.0.1/String.html#method-i-tr)
