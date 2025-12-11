# #394 Deck of Cards

Using the Io language to model a deck of cards, shuffle, and deal; cassidoo's interview question of the week (2025-12-08).

## Notes

The [interview question of the week (2025-12-08)](https://buttondown.com/cassidoo/archive/dont-watch-the-clock-do-what-it-does-keep-going)
asks us to model a deck of cards in code:

> Make a data structure for a deck of cards, and implement a shuffle() method, and a draw(n) method (where you draw n cards). Calling draw() when the deck is empty returns an empty array.
>
> Example usage:
>
> ```ts
> const deck = new Deck();
> deck.shuffle();
> console.log(deck.draw(5)); // Example: ['10♠', 'K♥', '3♣', 'J♦', '7♠']
> console.log(deck.draw(5).length); // 5
> console.log(deck.draw(2)); // Example: ['5♣', 'A♠']
> ```

## The Standard 52-card deck

The [standard 52-card deck](https://en.wikipedia.org/wiki/Standard_52-card_deck) of French-suited playing cards is the most common pack of playing cards used today. It contains 13 ranks in each of the four suits: clubs (♣), diamonds (♦), hearts (♥) and spades (♠): Ace, 2-10, Jack, Queen, King.

Major playing card manufacturers deliver new decks of playing cards arranged in "New Deck Order" (NDO): two Jokers (if any), then ascending the Ace-to-King of Spades, Ace-to-King of Diamonds, then descending King-to-Ace of Clubs, and finally King-to-Ace of Hearts.

## Thinking about the Problem

Our "Deck" object will probably need a constructor that sets up an internal card list in new deck order.

The `shuffle` method sounds trivial. But exactly how? Perhaps a series of random swaps:

* pick two random numbers from 1 to the number of cards in the deck: swap their positions
* repeat this some umber of times. At least to the size of the deck, may be a few times more.

The `draw(n)` method will just remove a card from a random position. Repeat until `n` cards drawn (or no cards remain).

The internal card list will be depleted as cards are drawn, so `shuffle` and `draw` methods must behave correctly when the ist is empty.

## First Solution

I am using Io on Ubuntu 24.04 for this exercise:

```sh
$ io --version
Io Programming Language, v. 20110905
```

For more on Io, see [LCK#393 About Io](../about/).

First let's initialize a Deck object with an internal cards list:

```io
suits := list("♠", "♦", "♣", "♥")
ranks := list("A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K")

Deck := Object clone do(
  cards ::= list()
  suits foreach(s,
    ranks foreach(r,
      cards append(r .. s)
    )
  )
)
```

The [Io List](https://iolanguage.org/reference/index.html#Core.List) object is
documented to have some handy methods for this problem such as `anyOne`, `shuffle`
but for some reason they are not available in my distribution.

We can add a shuffle as follows. A `pick_index` is just a common method to pick a random card,
and `shuffle` swaps all cards in the deck with another card position:

```io
cards pick_index := method(
  Random value(0, size) floor
)
cards shuffle := method(
  for(i, 0, size - 1,
    swapIndices(i, pick_index)
  )
)
```

When shuffling at the deck level, I'll repeat the card shuffle 3 times:

```io
Deck shuffle := method(
  "Shuffling the deck.." println
  3 repeat(cards shuffle)
  show_deck
)
```

Dealing just requires plucking the required number of cards from the deck.
Handily, the
[removeAt](https://iolanguage.org/reference/index.html#Core.List)
method removes and returns the card at the specified index in one go.

```io
Deck draw := method(n,
  result := list()
  n repeat(
    p := cards pick_index
    drawn := cards removeAt(p)
    result append(drawn)
  )
  result
)
```

Let's test it out:

```sh
$ io deck.io
Making a new deck of cards...
Cards in deck: list(A♠, 2♠, 3♠, 4♠, 5♠, 6♠, 7♠, 8♠, 9♠, 10♠, J♠, Q♠, K♠, A♦, 2♦, 3♦, 4♦, 5♦, 6♦, 7♦, 8♦, 9♦, 10♦, J♦, Q♦, K♦, A♣, 2♣, 3♣, 4♣, 5♣, 6♣, 7♣, 8♣, 9♣, 10♣, J♣, Q♣, K♣, A♥, 2♥, 3♥, 4♥, 5♥, 6♥, 7♥, 8♥, 9♥, 10♥, J♥, Q♥, K♥)
Shuffling the deck..
Cards in deck: list(7♥, A♣, 9♠, Q♦, K♥, A♥, J♣, 8♥, 10♠, 3♣, 2♥, 8♦, 6♠, 4♥, K♦, J♥, 8♣, 5♣, 10♥, 9♥, 5♠, 5♥, K♣, 2♣, 4♣, Q♠, 2♠, 7♦, 10♦, 2♦, 8♠, Q♥, A♦, 4♠, 10♣, 4♦, J♦, J♠, A♠, 9♦, 3♠, 7♣, K♠, Q♣, 6♣, 9♣, 3♥, 5♦, 6♦, 7♠, 3♦, 6♥)
Drawing 5 cards: list(7♣, 4♠, 2♠, 10♠, A♣)
Cards in deck: list(7♥, 9♠, Q♦, K♥, A♥, J♣, 8♥, 3♣, 2♥, 8♦, 6♠, 4♥, K♦, J♥, 8♣, 5♣, 10♥, 9♥, 5♠, 5♥, K♣, 2♣, 4♣, Q♠, 7♦, 10♦, 2♦, 8♠, Q♥, A♦, 10♣, 4♦, J♦, J♠, A♠, 9♦, 3♠, K♠, Q♣, 6♣, 9♣, 3♥, 5♦, 6♦, 7♠, 3♦, 6♥)
Drawing 5 cards: list(3♣, 4♦, 3♥, 7♠, 6♣)
Cards in deck: list(7♥, 9♠, Q♦, K♥, A♥, J♣, 8♥, 2♥, 8♦, 6♠, 4♥, K♦, J♥, 8♣, 5♣, 10♥, 9♥, 5♠, 5♥, K♣, 2♣, 4♣, Q♠, 7♦, 10♦, 2♦, 8♠, Q♥, A♦, 10♣, J♦, J♠, A♠, 9♦, 3♠, K♠, Q♣, 9♣, 5♦, 6♦, 3♦, 6♥)
Drawing 2 cards: list(8♥, 10♣)
Cards in deck: list(7♥, 9♠, Q♦, K♥, A♥, J♣, 2♥, 8♦, 6♠, 4♥, K♦, J♥, 8♣, 5♣, 10♥, 9♥, 5♠, 5♥, K♣, 2♣, 4♣, Q♠, 7♦, 10♦, 2♦, 8♠, Q♥, A♦, J♦, J♠, A♠, 9♦, 3♠, K♠, Q♣, 9♣, 5♦, 6♦, 3♦, 6♥)
```

Looking good!

### Example Code

Final code is in [deck.io](./deck.io):

```io
suits := list("♠", "♦", "♣", "♥")
ranks := list("A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K")

Deck := Object clone do(
  # constructor - setup the card deck
  cards ::= list()
  suits foreach(s,
    ranks foreach(r,
      cards append(r .. s)
    )
  )

  # add a cards method to pick a random card index
  cards pick_index := method(
    Random value(0, size) floor
  )
  # add a cards method to shuffle all the cards in the deck
  cards shuffle := method(
    for(i, 0, size - 1,
     swapIndices(i, pick_index)
    )
  )
)

# shuffle method for the Deck object - shuffles the cards a number of times
Deck shuffle := method(
  "Shuffling the deck.." println
  3 repeat(cards shuffle)
  show_deck
)

# draw method for the Deck object
Deck draw := method(n,
  result := list()
  n repeat(
    p := cards pick_index
    drawn := cards removeAt(p)
    result append(drawn)
  )
  result
)

# Convenience method to show the current cards
Deck show_deck := method(
  writeln("Cards in deck: ", cards)
)

# Convenience method to draw and display the cards in one call
Deck deal := method(n,
  drawn := draw(n)
  writeln("Drawing ", n, " cards: ", drawn)
  show_deck
  drawn
)

writeln("Making a new deck of cards...")
my_deck := Deck clone
my_deck show_deck
my_deck shuffle
my_deck deal(5)
my_deck deal(5)
my_deck deal(2)
```

## Credits and References

* [cassidoo's interview question of the week (2025-12-08)](https://buttondown.com/cassidoo/archive/dont-watch-the-clock-do-what-it-does-keep-going)
* <https://en.wikipedia.org/wiki/Standard_52-card_deck>
* [LCK#393 About Io](../about/)
* <https://iolanguage.org/>
