# #460 packSuitcases

Using Perl to pack suitcases; cassidoo's interview question of the week (2026-06-01).

## Notes

The [interview question of the week (2026-06-01)](https://buttondown.com/cassidoo/archive/u1fa88-life-is-what-happens-when-youre-busy/):

> Given an array of object weights and an array of suitcase capacities, determine the minimum number of suitcases needed to pack all objects, where each object must go into exactly one suitcase and each suitcase can hold any number of objects up to its capacity. Return -1 if it is impossible to pack all objects.
>
> Examples:
>
> ```ts
> packSuitcases([4, 8, 1, 4, 2], [10, 6, 8]);
> > 3
>
> packSuitcases([9, 7, 6], [10, 6]);
> > -1
> ```

### Thinking about the Problem

The problem sounds like a classic bin packing problem. These are generally NP-hard.

Exact solutions probably require integer linear programming, dynamic programming, or searching all possible combinations.

Some lighter heuristic models include:

* Best Fit Decreasing (BFD):
    * assign objects in order of decreasing weight
    * place into suitcase that leaves the least remaining space

Before proceeding with calculations, some simple feasibility checks include:

* total suitcase capacity must be >= total package weights
* largest single package must be <= largest suitcase

### A Solution

Before getting too convoluted, lest see how Best Fit Decreasing (BFD) performs.
A basic implementation:

```perl
sub packSuitcases {
  my ($packages, $suitcases) = @_;

  # Sort packages and suitcases by decreasing weight/capacity
  my @packages = sort { $b <=> $a } @$packages;
  my @suitcases = sort { $b <=> $a } @$suitcases;

  # Calculate totals
  my $total_package_weight = 0;
  $total_package_weight += $_ for @packages;

  my $total_suitcase_capacity = 0;
  $total_suitcase_capacity += $_ for @suitcases;

  # Feasibility checks
  return -1 if $total_suitcase_capacity < $total_package_weight;
  return -1 if @packages && @suitcases && $packages[0] > $suitcases[0];

  # Best Fit Decreasing algorithm
  my @remaining = @suitcases;
  my $packed_count = 0;

  foreach my $package (@packages) {
    my $best_idx = -1;
    my $best_fit = -1;

    for (my $i = 0; $i < @remaining; $i++) {
      if ($remaining[$i] >= $package) {
        my $leftover = $remaining[$i] - $package;
        if ($best_idx == -1 || $leftover < $best_fit) {
          $best_idx = $i;
          $best_fit = $leftover;
        }
      }
    }
    return -1 if $best_idx == -1;

    if ($remaining[$best_idx] == $suitcases[$best_idx]) {
      $packed_count++;
    }
    $remaining[$best_idx] -= $package;
  }

  return $packed_count;
}
```

And, good: it correctly handles the given examples no worries!

```sh
$ ./challenge.pl "4, 8, 1, 4, 2" "10, 6, 8"
# given packages=[4,8,1,4,2] and suitcases=[10,6,8], result is:
3
$ ./challenge.pl "9, 7, 6" "10, 6"
# given packages=[9,7,6] and suitcases=[10,6], result is:
-1
```

Best Fit Decreasing (BFD) is known to not always be optimal, but I'll leave it at that for now.

### Final Code

See [challenge.pl](./challenge.pl) for the final code.

```perl
#!/usr/bin/env perl
#
use strict;
use warnings;

sub packSuitcases {
  my ($packages, $suitcases) = @_;

  # Sort packages and suitcases by decreasing weight/capacity
  my @packages = sort { $b <=> $a } @$packages;
  my @suitcases = sort { $b <=> $a } @$suitcases;

  # Calculate totals
  my $total_package_weight = 0;
  $total_package_weight += $_ for @packages;

  my $total_suitcase_capacity = 0;
  $total_suitcase_capacity += $_ for @suitcases;

  # Feasibility checks
  return -1 if $total_suitcase_capacity < $total_package_weight;
  return -1 if @packages && @suitcases && $packages[0] > $suitcases[0];

  # Best Fit Decreasing algorithm
  my @remaining = @suitcases;
  my $packed_count = 0;

  foreach my $package (@packages) {
    my $best_idx = -1;
    my $best_fit = -1;

    for (my $i = 0; $i < @remaining; $i++) {
      if ($remaining[$i] >= $package) {
        my $leftover = $remaining[$i] - $package;
        if ($best_idx == -1 || $leftover < $best_fit) {
          $best_idx = $i;
          $best_fit = $leftover;
        }
      }
    }
    return -1 if $best_idx == -1;

    if ($remaining[$best_idx] == $suitcases[$best_idx]) {
      $packed_count++;
    }
    $remaining[$best_idx] -= $package;
  }

  return $packed_count;
}

sub asIntegerListParam {
  my ($param) = @_;
  my @list = split /,/, $param;
  @list = map { int($_) } @list;
  return \@list;
}

if (!caller()) {
  if (@ARGV != 2) {
    print STDERR "Usage: perl challenge.pl \"<package-list>\" \"<suitcase-list>\"\n";
    exit 1;
  }
  my @packages = @{asIntegerListParam($ARGV[0])};
  my @suitcases = @{asIntegerListParam($ARGV[1])};

  print "# given packages=[" . join(',', @packages) . "] and suitcases=[" . join(',', @suitcases) . "], result is:\n";

  my $result = packSuitcases(\@packages, \@suitcases);
  print "$result\n";
}

1;
```

### Tests

I've setup some validation in [challenge.t](./challenge.t):

```sh
$ prove -v challenge.t
challenge.t ..
ok 1 - example 1
ok 2 - example 2
1..2
ok
All tests successful.
Files=1, Tests=2,  0 wallclock secs ( 0.01 usr  0.01 sys +  0.01 cusr  0.00 csys =  0.03 CPU)
Result: PASS
```

## Credits and References

* [cassidoo's interview question of the week (2026-06-01)](https://buttondown.com/cassidoo/archive/u1fa88-life-is-what-happens-when-youre-busy/)
* [First-fit-decreasing bin packing](https://en.wikipedia.org/wiki/First-fit-decreasing_bin_packing)
