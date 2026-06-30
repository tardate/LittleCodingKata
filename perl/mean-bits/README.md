# #xxx meanBits

Using Perl to calculate mean bits; cassidoo's interview question of the week (2026-06-29).

## Notes

The [interview question of the week (2026-06-29)](https://buttondown.com/cassidoo/archive/u1f36b-great-success-doesnt-come-in-short-periods/):

> Given a positive integer n, calculate the mean number of bits required to represent all integers from 0 to n-1 (where the bit count of 0 is 1). Return the result rounded to two decimal places.
>
> Example:
>
> ```ts
> > meanBits(6)
> > 2.00
>
> // Explanation
> // 0: 1 bit, 1: 1 bit, 2: 2 bits, 3: 2 bits, 4: 3 bits, 5: 3 bits
> // Mean = (1 + 1 + 2 + 2 + 3 + 3) / 6 = 2.00
> ```

### Thinking about the Problem

In binary, the largest unsigned integer `n` that can be represented in a given number of bits `b` is `n = 2^b`.
Therefore the number of bits `b` required to represent a given number `n` is `b=int(log2(n)) + 1`.

So in Perl, for example with `n=5`:

```sh
$ perl -MPOSIX -e 'printf "%.2f\n", floor(log(5) / log(2)) + 1'
3.00
```

Another approach is to simply format as binary and count the string length, for example with `n=5`:

```sh
$ perl -e 'printf "%.2f\n", length(sprintf("%b", 5))'
3.00
```

A brute force method of calculation would be to iterate through all values`0..n` and sum the bits required for each.

An obvious optimisation would be to factor out and calculate all the bit steps in bulk. I think this could work by repeatedly diving by two and accumulating based on the modulo.

### A First Solution

Let's first do the naïve solution, simply iterate for all integers `0..n`.

In Perl:

* using the binary string formatting method
* returns the result explicitly rounded to 2 decimal places (as a string)

```perl
sub meanBits {
  my ($n) = @_;
  my $bit_count = 0;

  for my $i (0 .. $n - 1) {
    $bit_count += length(sprintf("%b", $i));
  }

  return sprintf("%.2f", $bit_count / $n);
}
```

And it handles the example correctly:

```sh
$ ./challenge.pl 6
# given n=6, result is:
2.00
```

But for large numbers, it chugs along a bit:

```sh
$ time perl challenge.pl 100000000
# given n=100000000, result is:
25.66

real    0m5.742s
user    0m5.715s
sys     0m0.022s
```

### Improved Algorithm

Let's try and speed that up by adding the explicit bit breaks. Like this:

```perl
sub meanBits_fast {
  my ($n) = @_;
  return '1.00' if $n == 0;
  return '0.00' if $n < 0;

  # handle 0 implicitly as 1 bit
  my $bits      = 1;
  my $count     = 1;
  my $bit_count = 1;
  my $remaining = $n - 1;

  # Process chunks of numbers that share the same bit length
  while ($remaining > 0) {
    my $chunk_size = 1 << ($bits - 1);

    if ($remaining < $chunk_size) {
      $chunk_size = $remaining;
    }

    $bit_count += $chunk_size * $bits;
    $remaining -= $chunk_size;
    $bits++;
  }

  return sprintf("%.2f", $bit_count / $n);
}
```

Now we get the same results, just much faster:

```sh
$ time perl challenge.pl 100000000
# given n=100000000, result using 'naive' algorithm is:
25.66

real    0m5.715s
user    0m5.669s
sys     0m0.026s
$ time perl challenge.pl 100000000 fast
# given n=100000000, result using 'fast' algorithm is:
25.66

real    0m0.029s
user    0m0.010s
sys     0m0.016s
```

### Final Code

See [challenge.pl](./challenge.pl) for the final code.

```perl
#!/usr/bin/env perl
#
use strict;
use warnings;

sub meanBits {
  my ($n) = @_;
  my $bit_count = 0;
  return '1.00' if $n == 0;
  return '0.00' if $n < 0;

  for my $i (0 .. $n - 1) {
    $bit_count += length(sprintf("%b", $i));
  }

  return sprintf("%.2f", $bit_count / $n);
}

sub meanBits_fast {
  my ($n) = @_;
  return '1.00' if $n == 0;
  return '0.00' if $n < 0;

  # handle 0 implicitly as 1 bit
  my $bits      = 1;
  my $count     = 1;
  my $bit_count = 1;
  my $remaining = $n - 1;

  # Process chunks of numbers that share the same bit length
  while ($remaining > 0) {
    my $chunk_size = 1 << ($bits - 1);

    if ($remaining < $chunk_size) {
      $chunk_size = $remaining;
    }

    $bit_count += $chunk_size * $bits;
    $remaining -= $chunk_size;
    $bits++;
  }

  return sprintf("%.2f", $bit_count / $n);
}

if (!caller()) {
  if (@ARGV < 1) {
    print STDERR "Usage: perl challenge.pl n\n";
    exit 1;
  }
  my $n = int($ARGV[0]);
  my $algorithm = $ARGV[1] // 'naive';

  print "# given n=$n, result using '$algorithm' algorithm is:\n";

  if ($algorithm eq 'fast') {
    my $result = meanBits_fast($n);
    printf "$result\n";
  } else {
    my $result = meanBits($n);
    printf "$result\n";
  }
}

1;
```

### Tests

I've setup some validation in [challenge.t](./challenge.t):

```sh
$ prove -v challenge.t
challenge.t ..
ok 1 - given example (naive algorithm)
ok 2 - handle 0 (naive algorithm)
ok 3 - handle negatives (naive algorithm)
ok 4 - handle big numbers (naive algorithm)
ok 5 - given example (fast algorithm)
ok 6 - handle 0 (fast algorithm)
ok 7 - handle negatives (fast algorithm)
ok 8 - handle big numbers (fast algorithm)
1..8
ok
All tests successful.
Files=1, Tests=8,  1 wallclock secs ( 0.00 usr  0.01 sys +  0.59 cusr  0.00 csys =  0.60 CPU)
Result: PASS
```

## Credits and References

* [cassidoo's interview question of the week (2026-06-29)](https://buttondown.com/cassidoo/archive/u1f36b-great-success-doesnt-come-in-short-periods/):
