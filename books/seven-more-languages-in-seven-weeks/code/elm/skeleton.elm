-- START:part1
module SomeGame where...

type alias Input = { ... }
type alias Player = { ... }
type alias Game = { player:Player, ... }
-- END:part1

-- START:part2
delta = inSeconds <~ fps n
input = sampleOn delta (...)
main  = map display gameState
gameState = foldp stepGame initialGameState input
-- END:part2

-- START:part3
stepGame input game = ...
display (w,h) game = ...
-- END:part3

