# #xxx comebackRound

Using ruby to find when the winner broke from the pack: cassidoo's interview question of the week (2026-11-08).

## Notes

The [interview question of the week (2026-11-08)](https://cassidoo.co/newsletter/2026-11-08/):

> Given rounds in a board game, where rounds[r][p] is the points player p earned in round r, find the earliest round from which the eventual winner is the sole leader at the end of every remaining round. Return the round number (1-based), or -1 if the final score is tied.
>
> Examples:
>
> ```ts
> > comebackRound([
>   [5, 3, 2],
>   [0, 5, 2],
>   [4, 2, 2],
>   [1, 3, 0],
> ]);
> > 2
>
> > comebackRound([
>   [4, 2],
>   [1, 3],
>   [2, 1],
> ]);
> > 3
>
> > comebackRound([
>   [4, 2],
>   [1, 3],
> ]);
> > -1
> ```

### Thinking about the Problem

To solve this, we need to know the accumulated score for each player in each round.
It seems two basic approaches:

* Single scan:
    * Iterate forwards, accumulating scores as we go
    * At each step, evaluate the leader
* Dual scan:
    * Scoring scan: iterate and calculate accumulated scores
    * Find the winning round: iterate in reverse from the final round, tracking the winner until the round this changes

There may be some marginal performance benefit for the dual scan approach in some cases(?), at the cost of extra memory.

Some practical decisions for setting up the code:

* the input data is an array; let's accept that as a JSON file

### Initial Solution

Let's start with the naïve single-scan approach. I'm taking full advantage of
[Enumerable](https://ruby-doc.org/core/Enumerable.html):

* [reduce (aka inject)](https://ruby-doc.org/core/Enumerable.html#method-i-reduce) to iterate the rounds with a memo object
* [zip](https://ruby-doc.org/core/Enumerable.html#method-i-zip) to accumulate the scores (and handle the initial nil-score case gracefully)
* [max](https://ruby-doc.org/core/Enumerable.html#method-i-max), [count](https://ruby-doc.org/core/Enumerable.html#method-i-count), and [index](https://ruby-doc.org/core/Enumerable.html#method-i-index) to find the winner

The rest is just book-keeping to track the winner and any change in poll position.

```ruby
def comebackRound(rounds)
  rounds.reduce(winning_round: -1, round: 0, winner: nil, scores: []) do |result, points|
    result[:scores] = points.zip(result[:scores]).map { |x, y| x + y.to_i }
    max_score = result[:scores].max
    if result[:scores].count(max_score) == 1 # we have a winner
      round_winner = result[:scores].index(max_score)
      if round_winner != result[:winner] # winner has changed
        result[:winner] = round_winner
        result[:winning_round] = result[:round] + 1 # 1-based
      end
    else
      result[:winning_round] = -1
      result[:winner] = nil
    end
    result[:round] += 1
    result
  end[:winning_round]
end
```

And that works nicely:

```sh
$ ./challenge.rb
Usage: ruby ./challenge.rb <json-file>
$ ./challenge.rb data-eg1.json
Rounds: [[5, 3, 2], [0, 5, 2], [4, 2, 2], [1, 3, 0]]
Result:
2
$ ./challenge.rb data-eg2.json
Rounds: [[4, 2], [1, 3], [2, 1]]
Result:
3
$ ./challenge.rb data-eg3.json
Rounds: [[4, 2], [1, 3]]
Result:
-1
```

### Improvement?

After writing that, do I think the dual-pass approach would be any better?

Here's a dual-pass implementation:

```ruby
def comebackRoundDualPass(rounds)
  tally = rounds.each_with_object([]) do |points, scores|
    scores << points.zip(scores.last || []).map { |x, y| x + y.to_i }
  end
  winning_round = -1
  winner = nil
  (tally.size - 1).downto(0) do |round|
    scores = tally[round]
    max_score = scores.max
    if scores.count(max_score) == 1 # we have a winner
      round_winner = scores.index(max_score)
      break if winner && round_winner != winner # winner has swapped
      winner = round_winner
      winning_round = round + 1 # 1-based
    else
      break
    end
  end
  winning_round
end
```

It works OK:

```sh
$ ./challenge.rb
Usage: ruby ./challenge.rb <json-file> <optional-algorithm>
$ ./challenge.rb data-eg1.json comebackRoundDualPass
Rounds: [[5, 3, 2], [0, 5, 2], [4, 2, 2], [1, 3, 0]]
comebackRoundDualPass Result:
2
$ ./challenge.rb data-eg2.json comebackRoundDualPass
Rounds: [[4, 2], [1, 3], [2, 1]]
comebackRoundDualPass Result:
3
$ ./challenge.rb data-eg3.json comebackRoundDualPass
Rounds: [[4, 2], [1, 3]]
comebackRoundDualPass Result:
-1
```

BUT:

* It's not particularly more elegant. In fact, I'd say it is worse.
* Although I haven't benchmarked the results, the possible performance improvement is likely negligible, and very much case-dependant (like tie in the final round)

So in conclusion I think I'd stick with my first approach.

### Tests

I've setup some validation in [test_challenge.rb](./test_challenge.rb):

```sh
$ ./test_challenge.rb
Run options: --seed 44694

# Running:

......

Finished in 0.000290s, 20689.6552 runs/s, 20689.6552 assertions/s.

6 runs, 6 assertions, 0 failures, 0 errors, 0 skips
```

### Final Code

Final code is in [challenge.rb](./challenge.rb):

```ruby
#!/usr/bin/env ruby
require 'json'

def comebackRound(rounds)
  rounds.reduce(winning_round: -1, round: 0, winner: nil, scores: []) do |result, points|
    result[:scores] = points.zip(result[:scores]).map { |x, y| x + y.to_i }
    max_score = result[:scores].max
    if result[:scores].count(max_score) == 1 # we have a winner
      round_winner = result[:scores].index(max_score)
      if round_winner != result[:winner] # winner has changed
        result[:winner] = round_winner
        result[:winning_round] = result[:round] + 1 # 1-based
      end
    else
      result[:winning_round] = -1
      result[:winner] = nil
    end
    result[:round] += 1
    result
  end[:winning_round]
end

def comebackRoundDualPass(rounds)
  tally = rounds.each_with_object([]) do |points, scores|
    scores << points.zip(scores.last || []).map { |x, y| x + y.to_i }
  end
  winning_round = -1
  winner = nil
  (tally.size - 1).downto(0) do |round|
    scores = tally[round]
    max_score = scores.max
    if scores.count(max_score) == 1 # we have a winner
      round_winner = scores.index(max_score)
      break if winner && round_winner != winner # winner has swapped
      winner = round_winner
      winning_round = round + 1 # 1-based
    else
      break
    end
  end
  winning_round
end

if __FILE__ == $PROGRAM_NAME
  (warn "Usage: ruby #{$0} <json-file> <optional-algorithm>"; exit) unless ARGV.length == 1 || ARGV.length == 2
  json_file_name = ARGV[0]
  begin
    rounds = JSON.parse(File.read(json_file_name))
  rescue
    puts "Error: Invalid JSON file - #{json_file_name}"
    exit
  end
  algorithm = ARGV[1] || 'comebackRound'
  warn "Rounds: #{rounds.inspect}"
  warn "#{algorithm} Result:"
  puts send(algorithm, rounds).inspect
end
```

## Credits and References

* [cassidoo's interview question of the week (2026-11-08)](https://cassidoo.co/newsletter/2026-11-08/)
* [Enumerable](https://ruby-doc.org/core/Enumerable.html)
