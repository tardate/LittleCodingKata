# #376 Singletons in Ruby

Using the singleton pattern in Ruby

## Notes

Some things are unique. The singleton pattern is used to implement a class that can only have a single instance.

The Singleton creational patterns was first made famous by the "Gang of Four" in [Design Patterns: Elements of Reusable Object-Oriented Software](../../design/design-patterns/). A ruby take is covered in [Design Patterns in Ruby](../design-patterns-in-ruby/), Chapter 12: Making Sure There Is Only One with the Singleton.

## Doing it By Hand

By making the `new` method private, we prevent anyone from creating an object using the conventional constructor.
Then we can use a class variable to record and return the same instance whenever requested.

See [amateur_soloist.rb](./amateur_soloist.rb) for an implementation:

```ruby
class AmateurSoloist
  @@instance = AmateurSoloist.new
  private_class_method :new

  def self.instance
    @@instance
  end

  def to_s
    "Amateur Soloist [object_id=#{object_id}]"
  end
end

if __FILE__==$PROGRAM_NAME
  (ARGV[0] || 2).to_i.times do |i|
    soloist = AmateurSoloist.instance
    puts "Instance #{i + 1}: #{soloist}"
  end
end
```

And it works as expected:

```sh
$ ruby amateur_soloist.rb 4
Instance 1: Amateur Soloist [object_id=60]
Instance 2: Amateur Soloist [object_id=60]
Instance 3: Amateur Soloist [object_id=60]
Instance 4: Amateur Soloist [object_id=60]
```

I've added accompanying tests in [test_amateur_soloist.rb](./test_amateur_soloist.rb):

```sh

$ ruby test_amateur_soloist.rb
Run options: --seed 20448

# Running:

..

Finished in 0.000211s, 9478.6730 runs/s, 9478.6730 assertions/s.

2 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```

There are limitations: it's not thread safe for example.
Instead adding thread safety ourselves, we can instead use the Singleton mixin supplied with Ruby

## Using Singleton Mixin

The [Singleton](https://ruby-doc.org/3.4.1/stdlibs/singleton/Singleton.html) module implements the Singleton pattern.

See [pro_soloist.rb](./pro_soloist.rb) for an implementation:

```ruby
class ProSoloist
  include Singleton

  def to_s
    "Pro Soloist [object_id=#{object_id}]"
  end
end

if __FILE__==$PROGRAM_NAME
  (ARGV[0] || 2).to_i.times do |i|
    soloist = ProSoloist.instance
    puts "Instance #{i + 1}: #{soloist}"
  end
end
```

And it works as expected:

```sh
$ ruby pro_soloist.rb 3
Instance 1: Pro Soloist [object_id=60]
Instance 2: Pro Soloist [object_id=60]
Instance 3: Pro Soloist [object_id=60]
```

I've added accompanying tests in [test_pro_soloist.rb](./test_pro_soloist.rb):

```sh
$ ruby test_pro_soloist.rb
Run options: --seed 3906

# Running:

..

Finished in 0.000227s, 8810.5727 runs/s, 8810.5727 assertions/s.

2 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```

## Considerations

The singleton pattern only really works in the context of a single thread or process (with a thread-safe implementation).

If one needs a true "singleton" in a multi-process or distributed scenario (such as in a web service), then other approaches are required such as semaphores or database locks.

## Credits and References

* [Design Patterns in Ruby](../design-patterns-in-ruby/) Chapter 12: Making Sure There Is Only One with the Singleton
* [Design Patterns: Elements of Reusable Object-Oriented Software](../../design/design-patterns/) Creational Patterns: Singleton
* <https://ruby-doc.org/3.4.1/stdlibs/singleton/Singleton.html>
