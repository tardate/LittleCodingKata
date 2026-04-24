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
  # Init to the maximum copies possible
  my $max_copies = int(length($input_string) / length($pattern));

  # First, determine the maximum copies based on non-wildcard characters
  for my $char (keys %pattern_freq) {
    my $available = $input_freq{$char} // 0;
    my $needed_per_copy = $pattern_freq{$char};
    my $copies_from_char = int($available / $needed_per_copy);
    $max_copies = $copies_from_char if $copies_from_char < $max_copies;
  }

  # Now use wildcards if possible...
  if ($wildcards > 0) {
    # Calculate how many characters remaining we have to play with
    my %input_surfeit_freq;
    for my $char (keys %pattern_freq) {
      my $available = $input_freq{$char} // 0;
      my $needed_per_copy = $pattern_freq{$char};
      my $used_for_copies = $needed_per_copy * $max_copies;
      $input_surfeit_freq{$char} = $available - $used_for_copies;
    }

    # Pluck wildcards one by one, see if we can form another copy..
    my $wildcards_used = 0;
    for (my $i = 1; $i <= $wildcards; $i++) {
      my $wildcards_needed = 0;
      my %deductions;
      for my $char (keys %pattern_freq) {
        my $available = $input_surfeit_freq{$char} // 0;
        my $needed_per_copy = $pattern_freq{$char};
        my $deficit = $needed_per_copy - $available;
        $deductions{$char} = $deductions{$char} // 0;
        if ($deficit > 0) {
          # Assume we use wildcards to cover this deficit
          $wildcards_needed += $deficit;
          $deductions{$char} += $available;
        } else {
          # We have enough of this char, so we can use it without wildcards
          $deductions{$char} += $needed_per_copy;
        }
      }
      # If we have enough wildcards to cover the deficits for this copy, we can form another copy
      if ($wildcards_needed <= $i - $wildcards_used) {
        $max_copies++;
        $wildcards_used += $wildcards_needed;
        # Update surfeit frequencies after using wildcards
        for my $char (keys %deductions) {
          $input_surfeit_freq{$char} -= $deductions{$char};
        }
      }
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
