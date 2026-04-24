#! /usr/bin/env perl
#
use strict;
use warnings;

sub maxPatternCopies {
  my ($input_string, $pattern) = @_;

  # Count frequency of each character in input and pattern
  my %input_freq;
  my %pattern_freq;
  $input_freq{$_}++ for split //, $input_string;
  $pattern_freq{$_}++ for split //, $pattern;

  # Calculate how many times we can form the pattern
  my $wildcards = $input_freq{'?'} // 0;
  my $max_copies = -1;

  # First, determine the maximum copies based on non-wildcard characters
  for my $char (keys %pattern_freq) {
    my $copies_from_char = int(($input_freq{$char} // 0) / $pattern_freq{$char});
    $max_copies = $copies_from_char if $copies_from_char < $max_copies || $max_copies < 0;
  }
  $max_copies = 0 if $max_copies < 0;

  if ($wildcards > 0) {
    # calculate how many characters remaining we have to play with after forming max_copies
    my %input_available;
    for my $char (keys %pattern_freq) {
      my $used_for_copies = $pattern_freq{$char} * $max_copies;
      $input_available{$char} = ($input_freq{$char} // 0) - $used_for_copies;
    }

    # repeatedly attempt to make additional patterns using wildcards until we run out of wildcards
    while ($wildcards > 0) {
      my $wildcards_needed = 0;
      for my $char (keys %pattern_freq) {
        my $available = $input_available{$char};
        my $needed_per_copy = $pattern_freq{$char};
        my $deficit = $needed_per_copy - $available;
        if ($deficit > 0) {
          # Assume we use wildcards to cover this deficit
          $wildcards_needed += $deficit;
          $input_available{$char} -= $available;
        } else {
          # We have enough of this char, so we can use it without wildcards
          $input_available{$char} += $needed_per_copy;
        }
      }
      last if $wildcards_needed > $wildcards; # we ran out of wildcards to make another copy
      $max_copies++;
      $wildcards -= $wildcards_needed;
    }
  }

  return $max_copies;
}

# Main script
if (@ARGV != 2) {
  print "Usage: perl challenge.pl \"<input-string>\" \"<pattern>\"\n";
  exit 1;
}

my ($input_string, $pattern) = @ARGV;
my $result = maxPatternCopies($input_string, $pattern);
print "$result\n";
