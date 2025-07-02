# #337 Last Non-repeating Character Challenge

Using ruby to return the last non-repeating character in a string; cassidoo's interview question of the week (2025-06-30). It's hard to stop AI butting in to help, but don't accept the first answer it gives you.

## Notes

The [interview question of the week (2025-06-30)](https://buttondown.com/cassidoo/archive/it-takes-courage-to-grow-up-and-become-who-you/)
stirred up some wonderful discussion and coding:

> Find the last non-repeating character in a given string. If all characters repeat, return an empty string.
>
> Example:
>
>     > nonRepeat('candy canes do taste yummy')
>     > 'u'

### Copilot Sticks Its Head Around the Corner

As soon as I started to type, Github Copilot wanted to suggest a solution for me.
This is what it produced:

    def last_non-repeating_character
      char_count = Hash.new(0)
      input.each_char { |char| char_count[char] += 1 }
      input.reverse.each_char do |char|
        return char if char_count[char] == 1
      end
      nil
    end

I renamed this `copilot_suggested` in [examples.rb](./examples.rb), and it tests just fine:

    $ ./examples.rb 'candy canes do taste yummy' copilot_suggested
    Using algorithm: copilot_suggested
    Input String: candy canes do taste yummy
    Result: u

I added tests for it in [test_examples.rb](./test_examples.rb).

    $ ./test_examples.rb
    Run options: --seed 22731

    # Running:

    ..

    Finished in 0.000239s, 8368.2008 runs/s, 8368.2008 assertions/s.

    2 runs, 2 assertions, 0 failures, 0 errors, 0 skips

### Idiomatic Ruby

But I don't like that code; it doesn't feel like ruby. For example:

* manually building a hash map
* multiple method returns

So again leaning on AI, I asked it for a more idiomatic version, and got this:

    def idiomatic_ruby_by_copilot
      char_count = input.each_char.tally
      input.reverse.each_char.find { |char| char_count[char] == 1 }
    end

Much nicer, and it also works:

    $ ./examples.rb 'candy canes do taste yummy' idiomatic_ruby_by_copilot
    Using algorithm: idiomatic_ruby_by_copilot
    Input String: candy canes do taste yummy
    Result: u

The [`tally`](https://ruby-doc.org/3.4.1/Enumerable.html#method-i-tally)
method takes care of counting the instances of each character rather than rolling our own iteration,
and the [`find`](https://ruby-doc.org/3.4.1/Enumerable.html#method-i-find)
method returns our result or nil, without needing separate logic or returns to
take care of the case where no non-repeating characters are found.

### A One-liner?

Can we reduce this further to a one-liner? Well, yes:

    def one_liner
      input.reverse.each_char.find { |char| input.count(char) == 1 }
    end

It looks cleaner, reducing the repeated iteration of the string across two lines.
In the one-liner, the second iteration is hidden in the inner `count` method,
so I'd expect this to perform much worse at scale, depending on how early in the string
the first non-repeating character is found.

### Example Code

Final code is in [examples.rb](./examples.rb):

    #!/usr/bin/env ruby

    class LastNonRepeatingCharacter
      attr_reader :input

      def initialize(input)
        @input = input
      end

      def copilot_suggested
        char_count = Hash.new(0)
        input.each_char { |char| char_count[char] += 1 }
        input.reverse.each_char do |char|
          return char if char_count[char] == 1
        end
        nil
      end

      def idiomatic_ruby_by_copilot
        char_count = input.each_char.tally
        input.reverse.each_char.find { |char| char_count[char] == 1 }
      end

      def one_liner
        input.reverse.each_char.find { |char| input.count(char) == 1 }
      end
    end


    if __FILE__==$PROGRAM_NAME
      (puts "Usage: ruby #{$0} (string) (algorithm)"; exit) unless ARGV.length > 0
      input = ARGV[0]
      algorithm = ARGV[1] || 'last_non_repeating_character'
      puts "Using algorithm: #{algorithm}"
      calculator = LastNonRepeatingCharacter.new(input)
      puts "Input String: #{calculator.input}"
      puts "Result: #{calculator.send(algorithm)}"
    end

With tests in [test_examples.rb](./test_examples.rb):

    $ ./test_examples.rb
    Run options: --seed 21160

    # Running:

    ......

    Finished in 0.000268s, 22388.0597 runs/s, 22388.0597 assertions/s.

    6 runs, 6 assertions, 0 failures, 0 errors, 0 skips

## Credits and References

* [cassidoo's interview question of the week (2025-06-30)](https://buttondown.com/cassidoo/archive/it-takes-courage-to-grow-up-and-become-who-you/)
