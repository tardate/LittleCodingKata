# #xxx longestSorted

Using ruby to find the longest word whose letters appear in alphabetical order; cassidoo's interview question of the week (2026-09-14).

## Notes

The [interview question of the week (2026-09-14)](https://buttondown.com/cassidoo/archive/u1f92a-theres-power-in-looking-silly-and-not/):

> Given a sentence, return the longest word whose letters appear in alphabetical order.
>
> Examples:
>
> ```ts
> > longestSorted("The autumn leaves almost glow.")
> > "almost"
>
> > longestSorted("A cool sheep sleeps.")
> > ""
> ```

### Thinking about the Problem

A couple of things to note about the examples:

* we are given sentences, with leading capitalisation and punctuation. So let's assume we need to ignore case and punctuation.
* "A" is not retuned as the answer in the second case, so assume we only consider words with more than 1 character.

Other than that, this should be straight-forward:

* tokenise the words (>1 char, ignore case, strip punctuation)
* filter for only those whose letters appear in alphabetical order
* find the longest

### A First Go

Let's treat this as 3 stages:

* split the sentence into words, lower-case, stripped of punctuation
* filter for only words over 1 char that have letters in alphabetical order
* get the longest

```ruby
  def words
    sentence.split.map { |word| word.downcase.gsub(/[^a-z]/, '') }
  end

  def alphabetically_sorted_words
    words.select { |word| word.length > 1 && word == word.chars.sort.join }
  end

  def longestSorted
    alphabetically_sorted_words.max_by { |word| word.length  } || ""
  end
```

And that works:

```sh
$ ./challenge.rb
Usage: ruby ./challenge.rb <sentence>
$ ./challenge.rb "The autumn leaves almost glow."
Sentence: "The autumn leaves almost glow."
Result: "almost"
$ ./challenge.rb "A cool sheep sleeps."
Sentence: "A cool sheep sleeps."
Result: ""
```

Could this be optimised? Yes, ofc:

* could be a one-liner
* rather than map all words and then find the longest, could short circuit that by mapping and selecting in one pass

### Tests

I've setup some validation in [test_challenge.rb](./test_challenge.rb):

```sh
$ ./test_challenge.rb
Run options: --seed 39519

# Running:

....

Finished in 0.000270s, 14814.8149 runs/s, 14814.8149 assertions/s.

4 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```

### Example Code

Final code is in [challenge.rb](./challenge.rb):

```ruby
#!/usr/bin/env ruby

class Challenge
  attr_accessor :sentence

  def initialize(sentence)
    self.sentence = sentence
  end

  def words
    sentence.split.map { |word| word.downcase.gsub(/[^a-z]/, '') }
  end

  def alphabetically_sorted_words
    words.select { |word| word.length > 1 && word == word.chars.sort.join }
  end

  def longestSorted
    alphabetically_sorted_words.max_by { |word| word.length  } || ""
  end
end

if __FILE__ == $PROGRAM_NAME
  (puts "Usage: ruby #{$0} <sentence>"; exit) unless ARGV.length == 1
  sentence = ARGV[0]
  calculator = Challenge.new(sentence)
  puts "Sentence: #{calculator.sentence.inspect}"
  puts "Result: #{calculator.longestSorted.inspect}"
end
```

## Credits and References

* [cassidoo's interview question of the week (2026-09-14)](https://buttondown.com/cassidoo/archive/u1f92a-theres-power-in-looking-silly-and-not/)
