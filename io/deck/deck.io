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
