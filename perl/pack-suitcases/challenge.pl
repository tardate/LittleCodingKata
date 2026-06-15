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
