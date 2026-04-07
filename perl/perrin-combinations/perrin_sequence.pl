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

sub print_array {
  my @array = @_;
  print "[" . join(',', @array) . "]\n";
}

if (@ARGV != 1) {
  print "Usage: perl perrin_sequence.pl n\n";
  exit 1;
}

my $n = $ARGV[0];
my @perrin = generate_perrin($n);
print_array(@perrin);
