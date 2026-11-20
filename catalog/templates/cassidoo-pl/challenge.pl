#!/usr/bin/env perl
#
use strict;
use warnings;

sub challengeFunction {
  my ($param1) = @_;
  # Implementation for the challenge function
}

if (!caller()) {
  if (@ARGV != 1) {
    print STDERR "Usage: perl challenge.pl <param1>\n";
    exit 1;
  }
  my $param1 = $ARGV[0];

  print STDERR "# given param1=$param1, result is:\n";

  my $result = challengeFunction($param1);
  print "$result\n";
}

1;
