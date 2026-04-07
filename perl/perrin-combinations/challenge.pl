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

sub uniq {
    my %seen;
    return grep { !$seen{$_}++ } @_;
}

sub perrin_combinations {
  my ($n, $k) = @_;
  my @perrin = uniq(generate_perrin($n));
  my %seen;
  my @results;

  my $num_elements = scalar @perrin;
  for my $mask (0 .. (1 << $num_elements) - 1) {
    my @subset;
    my $sum = 0;
    for my $i (0 .. $num_elements - 1) {
      if ($mask & (1 << $i)) {
        push @subset, $perrin[$i];
        $sum += $perrin[$i];
      }
    }
    if ($sum == $k) {
      my $key = join ',', sort { $a <=> $b } @subset;
      unless ($seen{$key}) {
        $seen{$key} = 1;
        push @results, [sort { $a <=> $b } @subset];
      }
    }
  }

  @results = sort { join(',', @$a) cmp join(',', @$b) } @results;
  return \@results;
}

sub print_2d_array {
  my $array = shift;
  print "[";
  for my $i (0 .. $#{$array}) {
    print "[" . join(',', @{$array->[$i]}) . "]";
    print "," unless $i == $#{$array};
  }
  print "]\n";
}

# Main script
if (@ARGV != 2) {
  print "Usage: perl challenge.pl n k\n";
  exit 1;
}

my ($n, $k) = @ARGV;
my $combinations = perrin_combinations($n, $k);
print_2d_array($combinations);
