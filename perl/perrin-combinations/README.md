# #438 perrinCombinations

Using Perl to calculate Perrin Combinations; cassidoo's interview question of the week (2026-04-06).

## Notes

The [interview question of the week (2026-04-06)](https://buttondown.com/cassidoo/archive/9-ufe0f-u20e3-there-are-no-mistakes-only/):

> Given an integer n, return all unique combinations of Perrin numbers (up to and including the nth Perrin number) that sum to a target value k, where each Perrin number can be used at most once. Return the combinations sorted in ascending order.
>
> Example:
>
> ```ts
> > perrinCombinations(7, 12)
> [[0,2,3,7],[0,5,7],[2,3,7],[5,7]]
>
> > perrinCombinations(6, 5)
> [[0,2,3],[0,5],[2,3],[5]]
> ```

## Thinking about the Problem

So firstly, what on earth is a [Perrin number](https://en.wikipedia.org/wiki/Perrin_number)?
A Perrin number is part of a specific integer sequence defined like this:

* Start with:
    * `P(0) = 3`
    * `P(1) = 0`
    * `P(2) = 2`
* Then for every number after that:
    * `P(n) = P(n−2) + P(n−3)`

So each new number is the sum of the number 2 steps back and 3 steps back.
The sequence begins: 3, 0, 2, 3, 2, 5, 5, 7, 10, 12, ...

Why is this interesting? The most famous reason is that for many prime numbers `p`, the Perrin sequence satisfies `P(p)` is divisible by `p`.
This is the Perrin primality test. It is not perfect — there are rare fake primes (called pseudo-primes) that also pass the test.

Relating this to the problem at hand:

* the Perrin sequence is somewhat incidental - it simply defines the seed array of integers that we will manipulate
    * this is the first task: given `n`, to generate the Perrin sequence up to the nth Perrin number
* find all different ways to combine those numbers so their sum equals the target value `k`
    * avoid duplicates
    * can only use each number in the sequence once
* sort the results

There are two ambiguities in the problem statement to resolve:

* what does the "nth Perrin number" mean? Conventionally, `n` is zero-based when presenting Perrin numbers, but as written, the question could mean the actually count i.e. the 5th Perrin number could mean return a total of 5 Perrin numbers, not 6 if is was considered zero-based.
    * the first example clarifies this: `n` must be zero-based, otherwise `7` cannot be in the result set
* what does "where each Perrin number can be used at most once". Since distinct integers appear repeatedly in the Perrin sequence, there are two interpretations:
    * each item in the Perrin sequence can only be used once
    * each unique integer in the Perrin sequence can only be used once

## A first approach

I decided to use Perl for this, specifically v5.34.1 on macOS:

```sh
$ perl --version

This is perl 5, version 34, subversion 1 (v5.34.1) built for darwin-thread-multi-2level
(with 2 registered patches, see perl -V for more detail)
```

I don't anticipate I'll need any additional libraries for this, as we are essentially doing array processing and permutations.

First, let's generate the sequence of Perrin numbers:

```perl
sub generate_perrin {
  my $n = shift;
  my @seq = (3, 0, 2);
  for my $i (3 .. $n) {
    push @seq, $seq[$i - 2] + $seq[$i - 3];
  }
  return @seq[0 .. $n];
}
```

The [perrin_sequence.pl](./perrin_sequence.pl) script generates the sequence. These are correct per the [definition](https://en.wikipedia.org/wiki/Perrin_number#Definition), but does not handle the reverse sequence with `n < 0`:

```sh
$ ./perrin_sequence.pl 2
[3,0,2]
$ ./perrin_sequence.pl 3
[3,0,2,3]
$ ./perrin_sequence.pl 6
[3,0,2,3,2,5,5]
$ ./perrin_sequence.pl 7
[3,0,2,3,2,5,5,7]
$ ./perrin_sequence.pl 10
[3,0,2,3,2,5,5,7,10,12,17]
```

Let's try an initial implementation. This assumes each item in the Perrin sequence can only be used once:

```perl
sub perrin_combinations {
  my ($n, $k) = @_;
  my @perrin = generate_perrin($n);
  my %seen;
  my @results;

  my $num_elements = scalar @perrin;
  for my $mask (0 .. (1 << $num_elements) - 1) {
    my @subset;
    my $sum = 0;
    for my $i (0 .. $num_elements - 1) {
      if ($mask & (1 << $i)) {
        push @subset, $perrin[$i];
        $sum += $perrin[$i];
      }
    }
    if ($sum == $k) {
      my $key = join ',', sort { $a <=> $b } @subset;
      unless ($seen{$key}) {
        $seen{$key} = 1;
        push @results, [sort { $a <=> $b } @subset];
      }
    }
  }

  @results = sort { join(',', @$a) cmp join(',', @$b) } @results;
  return \@results;
}
```

Results:

```sh
$ ./challenge.pl 7 12
[[0,2,2,3,5],[0,2,3,7],[0,2,5,5],[0,5,7],[2,2,3,5],[2,3,7],[2,5,5],[5,7]]
$ ./challenge.pl 6 5
[[0,2,3],[0,5],[2,3],[5]]
```

So `n=6, k=5` is correct, but `n=7, k=12` is too greedy.
Although we are not reusing items from the Perrin sequence, we have duplicates from the Perrin sequence that are not present in the examples provided.

Thus it appears clear that "where each Perrin number can be used at most once" needs to be interpreted as "each unique integer in the Perrin sequence can only be used once".

Let's change that:

```perl
sub uniq {
    my %seen;
    return grep { !$seen{$_}++ } @_;
}

sub perrin_combinations {
  my ($n, $k) = @_;
  my @perrin = uniq(generate_perrin($n));
  my %seen;
  my @results;

  my $num_elements = scalar @perrin;
  for my $mask (0 .. (1 << $num_elements) - 1) {
    my @subset;
    my $sum = 0;
    for my $i (0 .. $num_elements - 1) {
      if ($mask & (1 << $i)) {
        push @subset, $perrin[$i];
        $sum += $perrin[$i];
      }
    }
    if ($sum == $k) {
      my $key = join ',', sort { $a <=> $b } @subset;
      unless ($seen{$key}) {
        $seen{$key} = 1;
        push @results, [sort { $a <=> $b } @subset];
      }
    }
  }

  @results = sort { join(',', @$a) cmp join(',', @$b) } @results;
  return \@results;
}
```

And now the results are as expected:

```sh
$ ./challenge.pl 7 12
[[0,2,3,7],[0,5,7],[2,3,7],[5,7]]
$ ./challenge.pl 6 5
[[0,2,3],[0,5],[2,3],[5]]
```

### Final Code

See [challenge.pl](./challenge.pl) for the final code.

```perl
#! /usr/bin/env perl
#
use strict;
use warnings;

sub generate_perrin {
  my $n = shift;
  my @seq = (3, 0, 2);
  for my $i (3 .. $n) {
    push @seq, $seq[$i - 2] + $seq[$i - 3];
  }
  return @seq[0 .. $n];
}

sub uniq {
    my %seen;
    return grep { !$seen{$_}++ } @_;
}

sub perrin_combinations {
  my ($n, $k) = @_;
  my @perrin = uniq(generate_perrin($n));
  my %seen;
  my @results;

  my $num_elements = scalar @perrin;
  for my $mask (0 .. (1 << $num_elements) - 1) {
    my @subset;
    my $sum = 0;
    for my $i (0 .. $num_elements - 1) {
      if ($mask & (1 << $i)) {
        push @subset, $perrin[$i];
        $sum += $perrin[$i];
      }
    }
    if ($sum == $k) {
      my $key = join ',', sort { $a <=> $b } @subset;
      unless ($seen{$key}) {
        $seen{$key} = 1;
        push @results, [sort { $a <=> $b } @subset];
      }
    }
  }

  @results = sort { join(',', @$a) cmp join(',', @$b) } @results;
  return \@results;
}

sub print_2d_array {
  my $array = shift;
  print "[";
  for my $i (0 .. $#{$array}) {
    print "[" . join(',', @{$array->[$i]}) . "]";
    print "," unless $i == $#{$array};
  }
  print "]\n";
}

# Main script
if (@ARGV != 2) {
  print "Usage: perl challenge.pl n k\n";
  exit 1;
}

my ($n, $k) = @ARGV;
my $combinations = perrin_combinations($n, $k);
print_2d_array($combinations);
```

## Credits and References

* [cassidoo's interview question of the week (2026-04-06)](https://buttondown.com/cassidoo/archive/9-ufe0f-u20e3-there-are-no-mistakes-only/)
* <https://en.wikipedia.org/wiki/Perrin_number>
