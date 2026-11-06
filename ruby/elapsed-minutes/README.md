# #xxx elapsedMinutes

Using ruby to count the winks when the clocks go back: cassidoo's interview question of the week (2026-11-01).

## Notes

The [interview question of the week (2026-11-01)](https://cassidoo.co/newsletter/2026-11-01/):

> Given a chronological log of local "HH:MM" timestamps from the night daylight saving time ends, return the actual number of minutes between the first and last entries. The log contains a consecutive pair that reveals the clock’s one-hour rollback.
>
> Example:
>
> ```ts
> elapsedMinutes(["00:50", "01:10", "01:50", "01:10", "02:10"]);
> > 140
>
> elapsedMinutes(["01:55", "01:05", "01:25", "01:40"]);
> > 45
> ```

### Thinking about the Problem

The first part of the challenge is converting "HH:MM" timestamps to something that can be arithmetically manipulated.
In Ruby, we have a few options:

* (easy) custom function to convert the timestamp to minutes since midnight. This is fine as long as we don't need to deal with the wrap-around at midnight.
* [Time class](https://docs.ruby-lang.org/en/master/Time.html) supports conversion with `strptime`. Subtraction returns the difference in seconds. Can help with wrap-around at midnight but still needs to be told which day to use.
* [DateTime class](https://docs.ruby-lang.org/en/master/DateTime.html) supports conversion using `parse` or `strptime`. Subtraction returns the difference in days. Can help with wrap-around at midnight but still needs to be told which day to use.

Do we need to be concerned with the wrap-around at midnight? The given examples only use times on the same day. One could argue that if multi-day calculations are expected, then the data format should include the date and not just the time.

Next, let's think about whether we can expect a rollback in the sequence.

* the requirements are pretty emphatic that the log contains a one-hour rollback
* if there is a rollback, there can/should only be one: in the real-world the clocks don't go back twice without an intervening roll-forward (which we are not asked to handle)
* if it's possible for there not to be a rollback, then we need assurance that the times are logged at least once an hour, other wise a rollback may not be detected. There is no such assurance.

### Initial Solution

Let's be maximalist about the correctness and completeness of the requirements!

Given the requirements as-is, and assuming they are correct and complete, one must logically conclude:

* no midnight boundaries
* log must contain a one-hour rollback
* log contains only one rollback
* log cannot contain a roll-forward

In this case, all we need to do is difference the first and last entries. Everything else is irrelevant.

The Ruby Time and DateTime classes don't particularly bring much value in this case for their extra weight. So let's do this raw, for example:

```ruby
def to_minutes(timestamp)
  hours, minutes = timestamp.split(':').map(&:to_i)
  hours * 60 + minutes
end

def elapsedMinutes(timestamps)
  t1 = to_minutes(timestamps.first)
  t2 = to_minutes(timestamps.last)
  t2 - t1 + 60
end
```

And that works nicely:

```sh
$ ./challenge.rb
Usage: ruby ./challenge.rb <timestamps-csv>
$ ./challenge.rb "00:50, 01:10, 01:50, 01:10, 02:10"
Timestamps: ["00:50", "01:10", "01:50", "01:10", "02:10"]
Result:
140
$ ./challenge.rb "01:55, 01:05, 01:25, 01:40"
Timestamps: ["01:55", "01:05", "01:25", "01:40"]
Result:
45
```

### Refinement with Time

I'm not particularly happy with the `to_minutes` function.
There's a whole lot of data format issues etc that we might not be considering.
And it would require a complete replacement if some of those requirements like day boundaries ever change.

So let's relax a little and switch it out for the [Time class](https://docs.ruby-lang.org/en/master/Time.html):

```ruby
require 'time'

def elapsedMinutes(timestamps)
  t1 = Time.strptime(timestamps.first, "%H:%M")
  t2 = Time.strptime(timestamps.last, "%H:%M")
  (t2 - t1) / 60 + 60
end
```

All good:

```sh
$ ./challenge.rb "00:50, 01:10, 01:50, 01:10, 02:10" using_time_class 2> /dev/null
140
$ ./challenge.rb "01:55, 01:05, 01:25, 01:40" using_time_class 2> /dev/null
45
```

### Tests

I've setup some validation in [test_challenge.rb](./test_challenge.rb):

```sh
$ ./test_challenge.rb
Run options: --seed 60551

# Running:

......

Finished in 0.001084s, 5535.0554 runs/s, 7380.0738 assertions/s.

6 runs, 8 assertions, 0 failures, 0 errors, 0 skips
```

### Final Code

Final code is in [challenge.rb](./challenge.rb):

```ruby
#!/usr/bin/env ruby
require 'time'

def to_minutes(timestamp)
  hours, minutes = timestamp.split(':').map(&:to_i)
  hours * 60 + minutes
end

class Challenge
  attr_accessor :timestamps

  def initialize(timestamps)
    self.timestamps = timestamps
  end

  def using_time_class
    t1 = Time.strptime(timestamps.first, "%H:%M").to_i
    t2 = Time.strptime(timestamps.last, "%H:%M").to_i
    (t2 - t1) / 60 + 60
  end

  def raw
    t1 = to_minutes(timestamps.first)
    t2 = to_minutes(timestamps.last)
    t2 - t1 + 60
  end

  alias default raw
end

if __FILE__ == $PROGRAM_NAME
  (warn "Usage: ruby #{$0} <timestamps-csv> <algorithm>"; exit) unless ARGV.length == 1 || ARGV.length == 2
  timestamps = ARGV[0].split(',').map(&:strip)
  algorithm = ARGV[1] || 'default'
  warn "Using algorithm: #{algorithm}"
  calculator = Challenge.new(timestamps)
  warn "Timestamps: #{calculator.timestamps.inspect}"
  warn 'Result:'
  puts calculator.send(algorithm).inspect
end
```

## Credits and References

* [cassidoo's interview question of the week (2026-11-01)](https://cassidoo.co/newsletter/2026-11-01/)
* [Time class](https://docs.ruby-lang.org/en/master/Time.html)
* [DateTime class](https://docs.ruby-lang.org/en/master/DateTime.html)
