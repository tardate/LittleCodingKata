#!/usr/bin/env perl
#
use strict;
use warnings;

sub shuffleLine {
  my ($names, $n) = @_;
  return @$names if $n <= 0;
  my @result = ();
  my @endOfLine = ();
  for (my $i = 0; $i < @$names; $i++) {
    if (($i + 1) % $n == 0) {
      push @endOfLine, $names->[$i];
    } else {
      push @result, $names->[$i];
    }
  }
  push @result, @endOfLine;
  return @result;
}

if (!caller()) {
  if (@ARGV != 2) {
    print STDERR "Usage: perl challenge.pl \"<csv-names>\" <integer-n>\n";
    exit 1;
  }

  my ($names_string, $n) = @ARGV;
  my @names = split(/,/, $names_string);
  @names = map { s/^\s+|\s+$//g; $_ } @names;
  print "# given names=[" . join(',', @names) . "] and n=$n, result is:\n";

  my @result = shuffleLine(\@names, $n);
  print "[" . join(',', @result) . "]\n";
}

1;
