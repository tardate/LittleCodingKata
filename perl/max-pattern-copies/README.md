# #447 maxPatternCopies

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

## Improving the Algorithm

While we are getting the right answer, the initial approach looks quite inelegant and naïve: lots of reprocessing of the patterns and a step-wise reconstruction of the distribution of wildcards.

The main issue is determining how to optimally distribute the wildcards.
There is perhaps a queue processing algorithm that might be used - like a shortest processing time.

Let's tighten up the implementation

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
```

Does it check out? Yes, and even covers the "no matches" case :

```sh
$ ./challenge.pl "abcabc???" "ac"
3
$ ./challenge.pl "aab??" "aab"
1
$ ./challenge.pl "??????" "abc"
2
$ ./challenge.pl "aaaaab" "aaa"
1
$ ./challenge.pl "aaaaa?" "aaa"
2
$ ./challenge.pl "xyz" "abc"
0
$ ./challenge.pl "" "abc"
0
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
  print STDERR "Usage: perl challenge.pl \"<input-string>\" \"<pattern>\"\n";
  exit 1;
}

my ($input_string, $pattern) = @ARGV;
my $result = maxPatternCopies($input_string, $pattern);
print "$result\n";
```

## Credits and References

* [cassidoo's interview question of the week (2026-04-20)](https://buttondown.com/cassidoo/archive/u1f9f0-after-all-is-said-and-done-more-is-said/)
