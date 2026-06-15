# #463 maxSolitaireMoves

Using Perl to play solitaire; cassidoo's interview question of the week (2026-06-08).

## Notes

The [interview question of the week (2026-06-08)](https://buttondown.com/cassidoo/archive/u1f34e-what-we-know-is-a-drop-what-we-dont-know/):

> You have a "mini" version of solitaire in front of you. There is a row of cards, where each card has a rank from 1 to 13 and a color of "red" or "black". In one move, you may place a card onto another card immediately to its left if its rank is exactly one less and its color is opposite, then remove the moved card from its original position. Return the maximum number of valid moves you can make by repeatedly scanning left to right.
>
> Example:
>
> ```ts
> const cards = [
>   { rank: 7, color: "black" },
>   { rank: 6, color: "red" },
>   { rank: 5, color: "black" },
>   { rank: 9, color: "red" }
> ];
>
> const cards2 = [
>   { rank: 8, color: "black" },
>   { rank: 7, color: "red" },
>   { rank: 6, color: "red" },
>   { rank: 5, color: "black" }
> ];
>
> > maxSolitaireMoves(cards)
> > 2 // 6 onto 7, 5 onto 6
>
> > maxSolitaireMoves(cards2)
> > 2 // 7 onto 8, 5 onto 6
> ```

### Thinking about the Problem

It seems quite straight-forward:

* rank is just an integer, so don't need to worry about encoding picture cards
* matching is a little complex since we need to alternate colours in addition to matching the rank sequence

However we get a mysterious hint:

> ...repeatedly scanning left to right.

But is that a bum steer? The instructions are ambiguous on what would happen on a second pass:

* This is not a [normal game solitaire](https://en.wikipedia.org/wiki/Klondike_(solitaire)), but if matching of stacks is handled the same way:
    * then the bottom-most card must match the top-most card on the left
    * and thus the match would have been made on the first pass anyway ... any subsequent pass would not find any new matches
    * so "repeatedly scanning" is not necessary
* But the game rules **could** imply that when a card is moved and placed onto the card immediately to its left, it "hides" the previous card
    * the stack now has a new card value, and a subsequent pass **may** produce another move to the left
    * this is not explicitly stated in the rules, and only slightly implied by the use of the word "repeatedly"
    * but none of the given examples illustrate this behaviour

In the absence of strong evidence to the contrary, I'll go with "standard solitaire" rules.

### Module installation

I'm using Perl for this, and will be loading the card decks from JSON file, so first I'll install the [JSON](https://metacpan.org/pod/JSON) module.
[Log::Log4perl](https://metacpan.org/pod/Log::Log4perl) is not really necessary, but is recommended to improve logging for JSON.

```sh
$ cpan Log::Log4perl JSON
Reading '/Users/paulgallagher/.cpan/Metadata'
  Database was generated on Sun, 14 Jun 2026 09:29:02 GMT
Log::Log4perl is up to date (1.57).
JSON is up to date (4.11).
```

### A Solution

I'm assuming "standard solitaire" rules for stack matching, so this should be possible in one pass:

* from left to right, compare pairs of cards
    * if a "match", record it
* then move right by 1 and repeat

We can ignore all the moving of cards, because we don't need to compute the final deck setup, just the number of moves performed.

Here's a first go:

```perl
sub maxSolitaireMoves {
  my ($cards) = @_;
  my $moves = 0;

  for (my $i = 0; $i < scalar @$cards - 1; $i++) {
    if ((@$cards[$i]->{rank} == @$cards[$i + 1]->{rank} + 1) && (@$cards[$i]->{color} ne @$cards[$i + 1]->{color})) {
      $moves++;
    }
  }
  return $moves;
}
```

And it handles the examples correctly, given [cards.json](./cards.json) (example 1), and [cards2.json](./cards2.json) (example 2):

```sh
$ cat cards.json
[
  { "rank": 7, "color": "black" },
  { "rank": 6, "color": "red" },
  { "rank": 5, "color": "black" },
  { "rank": 9, "color": "red" }
]
$ ./challenge.pl cards.json
# given cards=[7:black, 6:red, 5:black, 9:red], result is:
2
$ cat cards2.json
[
  { "rank": 8, "color": "black" },
  { "rank": 7, "color": "red" },
  { "rank": 6, "color": "red" },
  { "rank": 5, "color": "black" }
]
$ ./challenge.pl cards2.json
# given cards=[8:black, 7:red, 6:red, 5:black], result is:
2
```

### Final Code

See [challenge.pl](./challenge.pl) for the final code.

```perl
#!/usr/bin/env perl
#
use strict;
use warnings;
use JSON;

sub maxSolitaireMoves {
  my ($cards) = @_;
  my $moves = 0;

  for (my $i = 0; $i < scalar @$cards - 1; $i++) {
    if ((@$cards[$i]->{rank} == @$cards[$i + 1]->{rank} + 1) && (@$cards[$i]->{color} ne @$cards[$i + 1]->{color})) {
      $moves++;
    }
  }
  return $moves;
}

sub readJsonFile {
  my ($filename) = @_;
  open my $fh, '<', $filename or die "Could not open file '$filename' $!";
  my $json_text = do { local $/; <$fh> };
  close $fh;
  return decode_json($json_text);
}

if (!caller()) {
  if (@ARGV != 1) {
    print "Usage: perl challenge.pl <cards-json-file-name>\n";
    exit 1;
  }
  my $filename = $ARGV[0];
  my $cards = readJsonFile($filename);

  print "# given cards=[" . join(', ', map { "$_->{rank}:$_->{color}" } @$cards) . "], result is:\n";

  my $result = maxSolitaireMoves($cards);
  print "$result\n";
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
1..2
ok
All tests successful.
Files=1, Tests=2,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.01 cusr  0.00 csys =  0.02 CPU)
Result: PASS
```

## Credits and References

* [cassidoo's interview question of the week (2026-06-08)](https://buttondown.com/cassidoo/archive/u1f34e-what-we-know-is-a-drop-what-we-dont-know/)
* [Solitaire](https://en.wikipedia.org/wiki/Klondike_(solitaire))
* [JSON](https://metacpan.org/pod/JSON)
* [Log::Log4perl](https://metacpan.org/pod/Log::Log4perl)
