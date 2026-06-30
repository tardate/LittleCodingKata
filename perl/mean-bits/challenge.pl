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
