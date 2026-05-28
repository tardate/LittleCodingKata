# #459 shuffle-line

Using Perl to move every nth customer to the end of the queue; cassidoo's interview question of the week (2026-05-25).

## Notes

The [interview question of the week (2026-05-25)](https://buttondown.com/cassidoo/archive/u26d1-ufe0f-permit-yourself-to-change-your-mind/):

> Given a queue of customer names and an integer n, move every nth customer to the end of the line while preserving relative order otherwise.
>
> Example:
>
> ```ts
> shuffleLine(["Ada", "Ben", "Cam", "Diya", "Eli", "Fay"], 3);
> > ['Ada', 'Ben', 'Diya', 'Eli', 'Cam', 'Fay']
> // Every 3rd customer is moved to the end, so "Cam" and "Fay"
> // are moved after the others, preserving their original order.
>
> shuffleLine(["A", "B", "C", "D", "E"], 2);
> > ['A', 'C', 'E', 'B', 'D']
>
> shuffleLine(["Mo", "Noah", "Oli"], 1);
> > ['Mo', 'Noah', 'Oli']
> ```

### Thinking about the Problem

Perhaps one way to think about it is how this would work in real life:
tell every nth customer in turn to form a new queue at the end on the line.

As an algorithm, the first question is perhaps whether to mutate the initial queue, or create a new queue holding the result.

If we mutate the initial queue:

* the resulting algorithm is a series of removing items from the queue and pushing them to the end of the queue
* the trick is to compensate for the changing structure of the queue and ensure it ends on the correct item
* the performance of this approach would really depend on how expensive deleting an array element is in the language of choice
* the approach benefits from only needing to visit the elements that are to be moved

If we create a new queue holding the result:

* we avoid issues with mutating the input array, but essentially need double the storage
* we need to visit all elements of the array
* we can avoid creating a third data structure (for the "end of the line" elements) by processing the input array twice:
    * first pass: skips every nth customer
    * second pass: visits every nth customer

### A first approach

I'll do what appears to be the simplest and most straight-forward approach:

* iterate all elements of the input array:
    * if the nth element, add to an "end of line" temporary array
    * else add to the result array
* return the result array with the end-of-line array appended

Here's the implementation. Note that I've also put in a condition that assumes if `n` is zero or negative, the queue is unchanged.

```perl
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
```

How does it fair? All good:

```sh
$ ./challenge.pl
Usage: perl challenge.pl "<csv-names>" <integer-n>
$ ./challenge.pl "Ada, Ben, Cam, Diya, Eli, Fay" 3
# given names=[Ada,Ben,Cam,Diya,Eli,Fay] and n=3, result is:
[Ada,Ben,Diya,Eli,Cam,Fay]
$ ./challenge.pl "A, B, C, D, E" 2
# given names=[A,B,C,D,E] and n=2, result is:
[A,C,E,B,D]
$ ./challenge.pl "Mo, Noah, Oli" 1
# given names=[Mo,Noah,Oli] and n=1, result is:
[Mo,Noah,Oli]
```

### Final Code

See [challenge.pl](./challenge.pl) for the final code.

```perl
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
    print "Usage: perl challenge.pl \"<csv-names>\" <integer-n>\n";
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
```

### Tests

I've setup some validation in [challenge.t](./challenge.t):

```sh
$ prove -v challenge.t
challenge.t ..
ok 1 - example 1
ok 2 - example 2
ok 3 - example 3
ok 4 - handles n=0 correctly
1..4
ok
All tests successful.
Files=1, Tests=4,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.01 cusr  0.00 csys =  0.02 CPU)
Result: PASS
```

## Credits and References

* [cassidoo's interview question of the week (2026-05-25)](https://buttondown.com/cassidoo/archive/u26d1-ufe0f-permit-yourself-to-change-your-mind/)
