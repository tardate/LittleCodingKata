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
