# #xxx konamiMapping

Using ruby to find a mapping that reveals the Konami Code in a string; cassidoo's interview question of the week (2026-01-19).

## Notes

The [interview question of the week (2026-01-19)](https://buttondown.com/cassidoo/archive/you-can-destroy-your-now-by-worrying-about/)
gives lots of string mapping vibes. I always prefer to reach for ruby in these cases.

> Given a string str, find a contiguous substring of length 10 whose characters can be bijectively mapped to the moves {U,D,L,R,B,A} so that the substring decodes to the Konami code "UUDDLRLRBA" (a character always maps to the same move, and two different moves can’t share a character). Return a valid mapping as an object.
>
> Example:
>
> ```ts
> konamiMapping("xx2233454590yy11110")
> > { "0": "A", "2": "U", "3": "D", "4": "L", "5": "R", "9": "B" }
>
> konamiMapping("sduwahoda22ii0d0dbn")
> > { "0": "L", "2": "U", "i": "D", "d": "R", "b": "B", "n": "A" }
> ```

### Thinking about the Problem

The [Konami Code](https://en.wikipedia.org/wiki/Konami_Code) "UUDDLRLRBA" is a cheat code that appeared in many Konami video games and became legend.

The problem asks us to find the code in a string by providing a mapping i.e. substitution rules that can be used to modify the string and reveal the code.
Looking at the examples:

* Given "xx2233454590yy11110" and mapping `{ "0": "A", "2": "U", "3": "D", "4": "L", "5": "R", "9": "B" }`,
    * mapped: "xxUUDDLRLRBAyy1111A"
* Given "sduwahoda22ii0d0dbn" and mapping `{ "0": "L", "2": "U", "i": "D", "d": "R", "b": "B", "n": "A" }`,
    * mapped: "sRuwahoRaUUDDLRLRBA"

That word ["bijective"](https://en.wikipedia.org/wiki/Bijection) is meaningful.
A bijective mapping is a mapping that is both:

* One-to-one (injective): Different things never map to the same result.
* Onto (surjective): Every allowed result is used by exactly one thing.

In mathematics, a bijection, bijective function, or one-to-one correspondence is a function between two sets such that each element of the second set (the codomain) is the image of exactly one element of the first set (the domain).

Some points to note:

* I'm assuming case-sensitive
* there's exactly 6 mappings required: {U,D,L,R,B,A} and all characters in the result must be mapped (else would not be bijective)
* we can't exclude the possibility of cross-mapping e.g. map `U` to `D` and something else to `U`.

Possible approaches:

* brute force sliding window and direct mapping: from each possible starting point, attempt to generate a mapping
* pattern normalization and comparison: encode the Konami code with a generic pattern rule to produce a canonical code/signature. Compare substrings using the same rules, and where they match a mapping should be possible

### A First Go

I'm attracted by the canonical pattern matching approach.

One possible algorithm is to count the first appearance of each distinct character in a string, and use that value in place of the character. e.g.:

```txt
Konami:  U U D D L R L R B A
Pattern: 0 0 1 1 2 3 2 3 4 5
```

Applying the same rules to another string:

```txt
Example: 2 2 i i 0 d 0 d b n
Pattern: 0 0 1 1 2 3 2 3 4 5
```

And since the patterns match, a mapping from the Example to Konami is possible. In this case:
`{ "2": "U", "i": "D", "0": "L", "d": "R", "b": "B", "n": "A" }`.

Sketching out a basic implementation:

```ruby
def konamiMapping(input)
  konami_code = 'UUDDLRLRBA'
  konami_signature = pattern_signature(konami_code)
  konami_length = konami_code.length
  result = nil

  (0..(input.length - konami_length)).each do |start_index|
    substring = input[start_index, konami_length]
    if pattern_signature(substring) == konami_signature
      result = bijective_mapping(substring, konami_code)
      break
    end
  end

  result
end
```

Running with the examples:

```sh
$ ./challenge.rb "xx2233454590yy11110"
Input String: xx2233454590yy11110
Mapped String: xxUUDDLRLRBAyy1111A
Result: {"2"=>"U", "3"=>"D", "4"=>"L", "5"=>"R", "9"=>"B", "0"=>"A"}
$ ./challenge.rb "sduwahoda22ii0d0dbn"
Input String: sduwahoda22ii0d0dbn
Mapped String: sRuwahoRaUUDDLRLRBA
Result: {"2"=>"U", "i"=>"D", "0"=>"L", "d"=>"R", "b"=>"B", "n"=>"A"}
```

### Tests

I've setup some validation in [test_challenge.rb](./test_challenge.rb):

```sh
$ ./test_challenge.rb
Run options: --seed 56172

# Running:

........

Finished in 0.000393s, 20356.2341 runs/s, 20356.2341 assertions/s.

8 runs, 8 assertions, 0 failures, 0 errors, 0 skips
```

### Example Code

Final code is in [challenge.rb](./challenge.rb):

```ruby
def apply_mapping(input, mapping)
  result = input.dup
  mapping.each do |given, substitute|
    result.gsub!(given, substitute)
  end
  result
end

def pattern_signature(input)
  mapping = {}
  next_code = 0
  signature = []

  input.each_char do |char|
    unless mapping.key?(char)
      mapping[char] = next_code
      next_code = next_code + 1
    end
    signature << mapping[char]
  end

  signature
end

def bijective_mapping(source, destination)
  mapping = {}
  destination.chars.each_with_index do |destination_char, index|
    given_char = source[index]
    mapping[given_char] = destination_char
  end
  mapping
end

def konamiMapping(input)
  Calculator.new(input).default
end

class Calculator
  attr_reader :input

  KONAMI_CODE = 'UUDDLRLRBA'

  def initialize(input)
    @input = input
  end

  def konami_signature
    @konami_signature ||= pattern_signature(KONAMI_CODE)
  end

  def konami_length
    @konami_length ||= KONAMI_CODE.length
  end

  def default
    (0..(input.length - konami_length)).each do |start_index|
      substring = input[start_index, konami_length]
      if pattern_signature(substring) == konami_signature
        return bijective_mapping(substring, KONAMI_CODE)
      end
    end

    nil
  end
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} (string)"; exit) unless ARGV.length > 0
  input = ARGV[0]
  algorithm = ARGV[1] || 'default'
  calculator = Calculator.new(input)
  result = calculator.send(algorithm)
  mapped = apply_mapping(input, result) if result
  puts "Input String: #{calculator.input}"
  puts "Mapped String: #{mapped}"
  puts "Result: #{result}"
end
```

## Credits and References

* [cassidoo's interview question of the week (2026-01-19)](https://buttondown.com/cassidoo/archive/you-can-destroy-your-now-by-worrying-about/)
* [Konami Code](https://en.wikipedia.org/wiki/Konami_Code)
* [Bijection](https://en.wikipedia.org/wiki/Bijection)
