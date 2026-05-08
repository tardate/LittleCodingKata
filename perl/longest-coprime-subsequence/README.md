# #xxx longestCoprimeSubsequence

Using Perl to calculate longest coprime subsequences; cassidoo's interview question of the week (2026-05-04).

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

My understanding of the question is that is asking:

* check every adjacent pair of elements to be tested if they are coprime (GCD==1)
* find the longest chain of coprime pairs

i.e. we can't reorder the array to put coprimes together, or ignore non-coprime elements

Given that understanding, the second example appears to be incorrect: the `longestCoprimeSubsequence([4, 3, 6, 9, 7, 2])`
should be the sequence [9, 7, 2] i.e. 3, not 4.
To get the illustrated answer `[4, 3, 7, 2], where gcd(4,3)=1, gcd(3,7)=1, gcd(7,2)=1`,
then the sequence should be `longestCoprimeSubsequence([4, 3, 7, 2, 6, 9])` instead.

I will proceed on that assumption.

### A first approach

Using perl for this: `perl 5, version 42, subversion 2 (v5.42.2) built for darwin-thread-multi-2level`.

We first need a GCD function, easily done:

```perl
sub gcd {
  my ($a, $b) = @_;
  while ($b) {
    ($a, $b) = ($b, $a % $b);
  }
  return $a;
}
```

Then a fist take on the `longestCoprimeSubsequence` function just brute forces the GCD calculation for all pairs in the list,
and keeps track of the longest coprime list found.

```perl
sub longestCoprimeSubsequence {
  my @numbers = @_;
  my $result = 0;
  my @coprime_numbers;
  my $prev_num = shift @numbers;
  for my $num (@numbers) {
    if (gcd($prev_num, $num) == 1) {
      push @coprime_numbers, $prev_num
    } else {
      $result = scalar @coprime_numbers if scalar @coprime_numbers > $result;
      @coprime_numbers = ();
    }
    $prev_num = $num;
  }
  $result = scalar @coprime_numbers if scalar @coprime_numbers > $result;
  return $result + 1;
}
```

We get the expected results when run interactively:

```sh
$ ./challenge.pl "6, 12, 4, 8"
1
$ ./challenge.pl "4, 3, 7, 2, 6, 9"
4
$ ./challenge.pl "4, 3, 6, 9, 7, 2"
3
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
  my $result = 0;
  my @coprime_numbers;
  my $prev_num = shift @numbers;
  for my $num (@numbers) {
    if (gcd($prev_num, $num) == 1) {
      push @coprime_numbers, $prev_num
    } else {
      $result = scalar @coprime_numbers if scalar @coprime_numbers > $result;
      @coprime_numbers = ();
    }
    $prev_num = $num;
  }
  $result = scalar @coprime_numbers if scalar @coprime_numbers > $result;
  return $result + 1;
}

if (!caller()) {
  if (@ARGV != 1) {
    print "Usage: perl challenge.pl \"<csv-integer-list>\"\n";
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
ok 12 - should find sequence of 3 coprime numbers (9, 7, 2)
1..12
ok
All tests successful.
Files=1, Tests=12,  0 wallclock secs ( 0.00 usr  0.00 sys +  0.01 cusr  0.00 csys =  0.01 CPU)
Result: PASS
```

## Credits and References

* [cassidoo's interview question of the week (2026-05-04)](https://buttondown.com/cassidoo/archive/u1fa96-focus-on-things-that-are-small-enough-to/)
