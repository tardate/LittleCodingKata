# #xxx maxPatternCopies

Using Perl to make patterns from a string; cassidoo's interview question of the week (2026-04-20).

## Notes

The [interview question of the week (2026-04-20)](https://buttondown.com/cassidoo/archive/u1f9f0-after-all-is-said-and-done-more-is-said/):

> Given a string s containing letters and ? wildcards (that can match any letter), and a target pattern string pattern, rearrange the entire string however you like. Return the maximum number of non-overlapping copies of pattern that can appear in the rearranged result.
>
> Example:
>
> ```ts
> maxPatternCopies("abcabc???", "ac")
> 3
>
> maxPatternCopies("aab??", "aab")
> 1
>
> maxPatternCopies("??????", "abc")
> 2
> ```

## Thinking about the Problem

We basically need to distribute the available characters and wildcards
into as many "pattern buckets" as possible (since we are only concerned with non-overlapping patterns).

By counting the instances of each target character in string `s`,
the minimum count is the number of patterns we can re-create without resorting to wildcards.

We can then distribute wildcards to "fill in the gaps" and make additional matches.

## A first approach

I decided to use Perl for this, specifically v5.42.2 on macOS:

```sh
$ perl --version

This is perl 5, version 42, subversion 2 (v5.42.2) built for darwin-thread-multi-2level
```

I don't anticipate I'll need any additional libraries for this, as we are essentially doing string and array processing.

Here's a first short. A fairly literal translation of the basic algorithm:

```perl
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
```

And now the results are as expected:

```sh
$ ./challenge.pl "abcabc???" "ac"
3
$ ./challenge.pl "aab??" "aab"
1
$ ./challenge.pl "??????" "abc"
2
```

### Final Code

See [challenge.pl](./challenge.pl) for the final code.

```perl
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
```

## Credits and References

* [cassidoo's interview question of the week (2026-04-20)](https://buttondown.com/cassidoo/archive/u1f9f0-after-all-is-said-and-done-more-is-said/)
