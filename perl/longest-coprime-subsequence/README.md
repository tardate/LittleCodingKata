# #455 longestCoprimeSubsequence

Using Perl to calculate longest coprime subsequence; cassidoo's interview question of the week (2026-05-04).

## Notes

The [interview question of the week (2026-05-04)](https://buttondown.com/cassidoo/archive/u1fa96-focus-on-things-that-are-small-enough-to/):

> Given an array of positive integers, find the length of the longest subsequence where every adjacent pair of elements in the subsequence is coprime (where the greatest common divisor, or GCD, is 1).
>
> Example:
>
> ```ts
> longestCoprimeSubsequence([6, 12, 4, 8])
> > 1 // none are coprime
>
> longestCoprimeSubsequence([4, 3, 6, 9, 7, 2])
> > 4 // [4, 3, 7, 2], where gcd(4,3)=1, gcd(3,7)=1, gcd(7,2)=1
> ```

### Thinking about the Problem

Key to understanding the problem is realizing that ["subsequence" has a very specific mathematical meaning](https://en.wikipedia.org/wiki/Subsequence),
and is [distinct from a subarray or subset](https://www.geeksforgeeks.org/dsa/array-subarray-subsequence-and-subset/).

Specifically a subsequence:

> is derived from a given sequence by deleting 0 or more elements without changing the order of the remaining elements.

I got this wrong on my first attempt: looking for a subarray instead of subsequence.

### A Solution

Using perl on macOS for this: `perl 5, version 42, subversion 2 (v5.42.2) built for darwin-thread-multi-2level`.

We first need a GCD function; easily done:

```perl
sub gcd {
  my ($a, $b) = @_;
  while ($b) {
    ($a, $b) = ($b, $a % $b);
  }
  return $a;
}
```

Then a first take on the `longestCoprimeSubsequence` function
simply works though the array, keeping track of the co-primes found.

```perl
sub longestCoprimeSubsequence {
  my @numbers = @_;
  my @coprime_numbers;
  my $prev_num = shift @numbers;
  for my $num (@numbers) {
    if (gcd($prev_num, $num) == 1) {
      push @coprime_numbers, $prev_num;
      $prev_num = $num;
    }
  }
  return scalar @coprime_numbers + 1;
}
```

This appears to be good enough to get the expected results for the examples provided:

```sh
$ ./challenge.pl "6, 12, 4, 8"
1
$ ./challenge.pl "4, 3, 6, 9, 7, 2"
4
```

### Final Code

See [challenge.pl](./challenge.pl) for the final code.

```perl
#!/usr/bin/env perl
#
use strict;
use warnings;

sub gcd {
  my ($a, $b) = @_;
  while ($b) {
    ($a, $b) = ($b, $a % $b);
  }
  return $a;
}

sub longestCoprimeSubsequence {
  my @numbers = @_;
  my @coprime_numbers;
  my $prev_num = shift @numbers;
  for my $num (@numbers) {
    if (gcd($prev_num, $num) == 1) {
      push @coprime_numbers, $prev_num;
      $prev_num = $num;
    }
  }
  return scalar @coprime_numbers + 1;
}

if (!caller()) {
  if (@ARGV != 1) {
    print STDERR "Usage: perl challenge.pl \"<csv-integer-list>\"\n";
    exit 1;
  }
  my $input_string = $ARGV[0];
  my @numbers = split /,/, $input_string;
  @numbers = map { int($_) } @numbers;
  my $result = longestCoprimeSubsequence(@numbers);
  print "$result\n";
}

1;
```

### Tests

I've setup some validation in [challenge.t](./challenge.t):

```sh
$ prove -v challenge.t
challenge.t ..
ok 1 - gcd output should indicate coprime
ok 2 - gcd output should indicate coprime
ok 3 - gcd output should indicate coprime
ok 4 - gcd output should indicate coprime
ok 5 - gcd output should indicate coprime
ok 6 - gcd output should indicate coprime
ok 7 - gcd output should be sane
ok 8 - gcd output should be sane
ok 9 - no coprime numbers
ok 10 - should find sequence of 4 coprime numbers (4, 3, 7, 2)
ok 11 - should find sequence of 4 coprime numbers (4, 3, 7, 2)
ok 12 - should find sequence of 5 coprime numbers (4, 3, 7, 2, 9)
1..12
ok
All tests successful.
Files=1, Tests=12,  0 wallclock secs ( 0.00 usr  0.01 sys +  0.01 cusr  0.00 csys =  0.02 CPU)
Result: PASS
```

## Credits and References

* [cassidoo's interview question of the week (2026-05-04)](https://buttondown.com/cassidoo/archive/u1fa96-focus-on-things-that-are-small-enough-to/)
* <https://en.wikipedia.org/wiki/Subsequence>
* <https://www.geeksforgeeks.org/dsa/array-subarray-subsequence-and-subset/>
