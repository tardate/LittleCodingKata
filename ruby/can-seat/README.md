# #xxx canSeat

Using ruby to seat some picky guests at a an event: cassidoo's interview question of the week (2026-11-23).

## Notes

The [interview question of the week (2026-11-23)](https://cassidoo.co/newsletter/2026-11-22/):

> You have two tables, a list of guests, and pairs of guests who can’t sit at the same table. Return true if you can seat everyone while respecting those pairs, or false otherwise.
>
> Examples:
>
> ```ts
> > canSeat(["Ang", "Ben", "Cam"], [["Ang", "Ben"], ["Ben", "Cam"]]);
> // true
>
> > canSeat(["Ang", "Ben", "Cam"], [
>   ["Ang", "Ben"], ["Ben", "Cam"], ["Cam", "Ang"]
> ]);
> // false
>
> > canSeat(["Ang", "Ben", "Cam"], []);
> // true
> ```

### Thinking about the Problem

Perhaps we can assume that the guests mentioned in the pairings must be on the guest list.
So the guest list itself is redundant.

To determine if we can honour the guest pairings, it should be possible to just seat each incompatible pairing in turn.
If at any point we can't complete a seating because of a conflict, then we've failed and need another table. Otherwise we have completed the seating challenge.

For a test program, let's accept the guest list and incompatible pairs as JSON-like strings

### Initial Solution

Here's a fairly naïve approach, leaning heavily on Ruby's `include?` method:

```ruby
def canSeat(guests, incompatible_pairs)
  table1 = []
  table2 = []
  incompatible_pairs.each do |guest_a, guest_b|
    if !table1.include?(guest_a) && !table2.include?(guest_a)
      # if guest_a is not already seated, try to seat based on where guest_b may already be seated
      if table1.include?(guest_b)
        table2 << guest_a
      elsif table2.include?(guest_b)
        table1 << guest_a
      else
        table1 << guest_a
        table2 << guest_b
      end
    else
      # guest_a is already seated, so must seat guest_b at the other table
      if table1.include?(guest_a) && !table1.include?(guest_b)
        table2 << guest_b unless table2.include?(guest_b)
      elsif table2.include?(guest_a) && !table2.include?(guest_b)
        table1 << guest_b unless table1.include?(guest_b)
      else
        # oops, we can't seat both guests at different tables
        return false
      end
    end
  end
  true
end
```

And that seems to work OK:

```sh
$ ./challenge.rb '["Ang", "Ben", "Cam"]' '[["Ang", "Ben"], ["Ben", "Cam"]]'
Guests: ["Ang", "Ben", "Cam"]
Incompatible Pairs: [["Ang", "Ben"], ["Ben", "Cam"]]
Result:
true
$ ./challenge.rb '["Ang", "Ben", "Cam"]' '[["Ang", "Ben"], ["Ben", "Cam"], ["Cam", "Ang"]]'
Guests: ["Ang", "Ben", "Cam"]
Incompatible Pairs: [["Ang", "Ben"], ["Ben", "Cam"], ["Cam", "Ang"]]
Result:
false
$ ./challenge.rb '["Ang", "Ben", "Cam"]' '[]'
Guests: ["Ang", "Ben", "Cam"]
Incompatible Pairs: []
Result:
true
```

### Improving the code

The code does a lot of faffing about checking where the guests may already be seated
I can clean that up quite a bit by pre-calculating the current seating:

```ruby
def canSeat(guests, incompatible_pairs)
  tables = [[], []]
  incompatible_pairs.each do |guest_a, guest_b|
    guest_a_seated_at = tables[0].include?(guest_a) ? 0 : (tables[1].include?(guest_a) ? 1 : nil)
    guest_b_seated_at = tables[0].include?(guest_b) ? 0 : (tables[1].include?(guest_b) ? 1 : nil)
    if guest_a_seated_at.nil?
      if guest_b_seated_at.nil?
        tables[0] << guest_a
        tables[1] << guest_b
      else
        tables[guest_b_seated_at == 0 ? 1 : 0] << guest_a
      end
    else
      return false if guest_b_seated_at == guest_a_seated_at
      tables[guest_a_seated_at == 0 ? 1 : 0] << guest_b unless guest_b_seated_at
    end
  end
  true
end
```

But that is still somewhat repetitive: once a guest is already seated, we potentially keep recalculating their position. So rather than track tables, it may be better to track guests.

This is perhaps more a idiomatic and easy to understand implementation:

```ruby
def canSeat(guests, incompatible_pairs)
  guest_seating = {}
  incompatible_pairs.each do |guest_a, guest_b|
    if guest_seating[guest_a].nil?
      if guest_seating[guest_b].nil?
        guest_seating[guest_a] = 0
        guest_seating[guest_b] = 1
      else
        guest_seating[guest_b] = 1 - guest_seating[guest_a]
      end
    else
      return false if guest_seating[guest_a] == guest_seating[guest_b]

      guest_seating[guest_b] = 1 - guest_seating[guest_a]
    end
  end
  true
end
```

But that's still a little verbose. Let's clean it up a bit more:

```ruby
def canSeat(guests, incompatible_pairs)
  guest_seating = {}
  incompatible_pairs.each do |guest_a, guest_b|
    if !guest_seating.key?(guest_a) && !guest_seating.key?(guest_b)
        guest_seating[guest_a] = 0
        guest_seating[guest_b] = 1
    else
      guest_seating[guest_a] ||= 0
      guest_seating[guest_b] ||= 1 - guest_seating[guest_a]
    end

    return false if guest_seating[guest_a] == guest_seating[guest_b]
  end
  true
end
```

And that's working too .. at least for all the tests I've defined.

Note: I haven't bench-marked all these approaches, but I suspect there is minimal performance difference between them.

### Tests

I've setup some validation in [test_challenge.rb](./test_challenge.rb):

```sh
$ ./test_challenge.rb
Run options: --seed 4482

# Running:

...

Finished in 0.000264s, 11363.6364 runs/s, 11363.6364 assertions/s.

3 runs, 3 assertions, 0 failures, 0 errors, 0 skips
```

### Final Code

Final code is in [challenge.rb](./challenge.rb):

```ruby
#!/usr/bin/env ruby
require 'json'

def canSeat(guests, incompatible_pairs)
  guest_seating = {}
  incompatible_pairs.each do |guest_a, guest_b|
    if !guest_seating.key?(guest_a) && !guest_seating.key?(guest_b)
        guest_seating[guest_a] = 0
        guest_seating[guest_b] = 1
    else
      guest_seating[guest_a] ||= 0
      guest_seating[guest_b] ||= 1 - guest_seating[guest_a]
    end

    return false if guest_seating[guest_a] == guest_seating[guest_b]
  end
  true
end

if __FILE__ == $PROGRAM_NAME
  (warn "Usage: ruby #{$0} <guests> <incompatible_pairs>"; exit) unless ARGV.length == 2
  guests = JSON.parse(ARGV[0])
  incompatible_pairs = JSON.parse(ARGV[1])
  warn "Guests: #{guests.inspect}"
  warn "Incompatible Pairs: #{incompatible_pairs.inspect}"
  warn 'Result:'
  puts canSeat(guests, incompatible_pairs)
end
```

## Credits and References

* [cassidoo's interview question of the week (2026-11-23)](https://cassidoo.co/newsletter/2026-11-22/)
