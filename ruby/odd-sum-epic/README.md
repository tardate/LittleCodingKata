# #335 The Odd-sum Epic

Cassidy Williams recently featured a ruby coding interview question that spurred a lively discussion of algorithms, and a general marvelling at the loveliness of ruby's Enumerable class. There was however a bit of a requirements trap in the question, not uncommon IRL, but had me wondering how well generative AI would cope. I put ChatGPT and Deepseek to the test, and the results are in!

## Notes

Cassidy stirred up some wonderful discussion and coding with the
[interview question of the week](https://buttondown.com/cassidoo/archive/false-expectations-take-away-joy-sandra-bullock/)
(2025-05-26):

> Given two arrays, return all pairs (where each number is in each array) whose sum is an odd number.
>
> Examples:
>
> oddSum([9, 14, 6, 2, 11], [8, 4, 7, 20])
>
> => [9, 20], [14, 7], [11,8]
>
> oddSum([2, 4, 6, 8], [10, 12, 14])
>
> => null // (or whatever falsy value you prefer)

I first cam across the question when I saw
Andy Croll's post on the subject:
[Further Performance Testing Enumerable’s Loveliness](https://andycroll.com/ruby/further-options-odd_sum-with-benchmarking/).

As all the good work on algorithms and performance has already been done, my attention was drawn elsewhere.

I immediately noticed something off in first example provided: it apparently implies that each element must be uniquely paired with an element in the other array, which doesn't really match the written requirement.

The written requirement asks for all pairs, perhaps implying an element can be used multiple times to make all possible pairs that add to an odd number. Under these rules, the expected pairs would be:
`[9, 8], [9, 4], [9, 20], [14, 7], [6, 7], [2, 7], [11, 8], [11, 4], [11, 20]`

This is good demonstration of written requirements being in conflict with examples provided. As the requirements analyst, your job is to figure out if the examples are just wrong, or if they actually convey additional important details and clarifications of the requirement.

Throughout my career, I can confidently state that this is less the exception than the rule. It is simple human nature that many people will confidently state "THIS is my requirement" and then give you half a dozen examples that contradict the requirement to one degree or another.

So what is one to do?
I have never found a better solution than simply to ask more questions! It is easy. There is no general rule for whether words should trump examples or vice versa.

### AI On the Job

I wonder how AI handles this common human confusion?

Here's my basic prompt:

> What is the best way to interpret the following requirement, and how would you reduce this to an algorithm and implementation in ruby.
> The requirement, with examples: "Given two arrays, return all pairs (where each number is in each array) whose sum is an odd number."
>
> Examples:
>
> oddSum([9, 14, 6, 2, 11], [8, 4, 7, 20])
>
> => [9, 20], [14, 7], [11,8]
>
> oddSum([2, 4, 6, 8], [10, 12, 14])
>
> => null // (or whatever falsy value you prefer)

#### ChatGPT

No hesitation here... ChatGPT is confident it got this right. Let's see!

##### ChatGPT Initial Response (A)

> The requirement is to find all pairs from two input arrays whose sum is an odd number. Here's how to interpret and break it down:
>
> ✅ Interpretation
>
> * Input: Two arrays of integers.
> * Output: A list of 2-element arrays (pairs) [a, b] where:
>     * a comes from the first array.
>     * b comes from the second array.
>     * a + b is odd.
>
> If there are no such pairs, return nil (or another falsy value like false or empty array [] depending on your style).
>
> 🧠 Algorithm in plain steps
>
> * Initialize an empty array to store results.
> * Loop through each element a in the first array.
> * For each a, loop through each element b in the second array.
> * If (a + b) % 2 == 1, it's an odd sum ⇒ add [a, b] to result.
> * After processing all pairs:
>     * If result is empty, return nil.
>     * Else, return the result array.
>
> 💎 Ruby Implementation

```ruby
def odd_sum(arr1, arr2)
  result = []

  arr1.each do |a|
    arr2.each do |b|
      result << [a, b] if (a + b).odd?
    end
  end

  result.empty? ? nil : result
end

# Examples:
p odd_sum([9, 14, 6, 2, 11], [8, 4, 7, 20])
# => [[9, 20], [14, 7], [11, 8]]

p odd_sum([2, 4, 6, 8], [10, 12, 14])
# => nil
```

> 🧪 Optional Enhancements
> If performance matters (e.g., for large arrays), you could:
>
> * Pre-partition each array into odds and evens.
> * Since:
>     * odd + even = odd
>     * even + odd = odd
> You could then:
> * Pair all odds from arr1 with evens from arr2.
> * Pair all evens from arr1 with odds from arr2.
>
> Let me know if you'd like that optimized version too!

I asked for the optimised version:

> 💎 Optimized Ruby Implementation
>

```ruby
def odd_sum(arr1, arr2)
  # Partition arr1
  odds1, evens1 = arr1.partition(&:odd?)
  # Partition arr2
  odds2, evens2 = arr2.partition(&:odd?)

  result = []

  # Add pairs: odd from arr1 + even from arr2
  odds1.each do |a|
    evens2.each do |b|
      result << [a, b]
    end
  end

  # Add pairs: even from arr1 + odd from arr2
  evens1.each do |a|
    odds2.each do |b|
      result << [a, b]
    end
  end

  result.empty? ? nil : result
end

# Test examples:
p odd_sum([9, 14, 6, 2, 11], [8, 4, 7, 20])
# => [[9, 8], [9, 4], [9, 20], [14, 7], [6, 7], [2, 7], [11, 8], [11, 4], [11, 20]]

p odd_sum([2, 4, 6, 8], [10, 12, 14])
# => nil
```

##### ChatGPT (A) Results

So how did it go?
Here's the first example using the initial algorithm suggested:

```sh
$ ./examples.rb chat_gpt_a "9, 14, 6, 2, 11" "8, 4, 7, 20"
Using algorithm: chat_gpt_a
Array 1: [9, 14, 6, 2, 11]
Array 2: [8, 4, 7, 20]
Result: [[9, 8], [9, 4], [9, 20], [14, 7], [6, 7], [2, 7], [11, 8], [11, 4], [11, 20]]
$ ./examples.rb chat_gpt_a "2, 4, 6, 8" "10, 12, 14"
Using algorithm: chat_gpt_a
Array 1: [2, 4, 6, 8]
Array 2: [10, 12, 14]
Result: nil
```

So:

* ChatGPT implemented the algorithm in line with the words of the requirements
* Given this understanding, it generates a correct results
* It ignored the contradictory example
* And even told me that the algorithm would generate the results as given in the example (which is incorrect)

How about the optimised algorithm::

```sh
$ ./examples.rb chat_gpt_a_optimised "9, 14, 6, 2, 11" "8, 4, 7, 20"
Using algorithm: chat_gpt_a_optimised
Array 1: [9, 14, 6, 2, 11]
Array 2: [8, 4, 7, 20]
Result: [[9, 8], [9, 4], [9, 20], [11, 8], [11, 4], [11, 20], [14, 7], [6, 7], [2, 7]]
$ ./examples.rb chat_gpt_a_optimised "2, 4, 6, 8" "10, 12, 14"
Using algorithm: chat_gpt_a_optimised
Array 1: [2, 4, 6, 8]
Array 2: [10, 12, 14]
Result: nil
```

Same behaviour, although array element order has changed.

### Deepseek

How does Deepseek fare if I give it the same prompt?

#### Deepseek Response

To interpret the requirement, we need to return all possible pairs (one element from each array) where the sum of the pair is an odd number. A sum is odd if one number is even and the other is odd. The solution involves:

1. **Separate elements** in each array into even and odd groups.
2. **Generate pairs** by combining:
   * Even elements from the first array with odd elements from the second array.
   * Odd elements from the first array with even elements from the second array.
3. **Return all valid pairs** or `nil` if no pairs exist.

### Algorithm

1. For the first array, collect:
   * `evens1`: All even numbers.
   * `odds1`: All odd numbers.
2. For the second array, collect:
   * `evens2`: All even numbers.
   * `odds2`: All odd numbers.
3. Initialize an empty list for `pairs`.
4. For each even number in `evens1`, pair it with every odd number in `odds2` and add to `pairs`.
5. For each odd number in `odds1`, pair it with every even number in `evens2` and add to `pairs`.
6. If `pairs` is empty, return `nil`; otherwise, return `pairs`.

### Ruby Implementation

```ruby
def odd_sum(arr1, arr2)
  evens1 = arr1.select(&:even?)
  odds1  = arr1.select(&:odd?)
  evens2 = arr2.select(&:even?)
  odds2  = arr2.select(&:odd?)

  pairs = []
  evens1.each { |e| odds2.each { |o| pairs << [e, o] } }
  odds1.each { |o| evens2.each { |e| pairs << [o, e] } }

  pairs.empty? ? nil : pairs
end
```

### Explanation

* **Grouping Elements**: The arrays are split into even and odd numbers for efficient pairing.

* **Generating Pairs**:
    * Even numbers from `arr1` are paired with all odd numbers from `arr2`.
    * Odd numbers from `arr1` are paired with all even numbers from `arr2`.
* **Handling No Pairs**: Returns `nil` if no valid pairs are found, as specified.

### Example Outputs

1. `odd_sum([9, 14, 6, 2, 11], [8, 4, 7, 20])` returns all 9 valid pairs:
   `[[14, 7], [6, 7], [2, 7], [9, 8], [9, 4], [9, 20], [11, 8], [11, 4], [11, 20]]`.
2. `odd_sum([2, 4, 6, 8], [10, 12, 14])` returns `nil` (no valid pairs).

**Note**: The example in the query only shows 3 pairs, but the requirement asks for **all pairs**. If the intended output is a subset (like one pair per element), additional constraints (e.g., using each element only once) must be specified. The provided solution follows the literal requirement.

#### Running the Deepseek Code

Running the code:

```sh
$ ./examples.rb deepseek_a "9, 14, 6, 2, 11" "8, 4, 7, 20"
Using algorithm: deepseek_a
Array 1: [9, 14, 6, 2, 11]
Array 2: [8, 4, 7, 20]
Result: [[14, 7], [6, 7], [2, 7], [9, 8], [9, 4], [9, 20], [11, 8], [11, 4], [11, 20]]
$ ./examples.rb deepseek_a "2, 4, 6, 8" "10, 12, 14"
Using algorithm: deepseek_a
Array 1: [2, 4, 6, 8]
Array 2: [10, 12, 14]
Result: nil
```

Conclusions:

* again, deepseek has favoured the understanding according to the words of the requirement rather than the examples
* HOWEVER:
    * it has flagged the inconsistency in the requirement
    * has told me the result it will actually produce (not give me the incorrect example)
    * and suggested how I could clarify the requirement if the example is in fact correct
* The code it has generated:
    * executes correctly
    * has chosen to use select rather than partition

### Benchmarking

How do the three implementations so far compare. We have:

* `chat_gpt_a` - is the naïve full scan of both arrays
* `chat_gpt_a_optimised` - uses [`partition`](https://apidock.com/ruby/v2_6_3/Enumerable/partition) to select odds and evens before combining
* `deepseek_a` - uses [`select`](https://apidock.com/ruby/v2_6_3/Enumerable/select) to select odds and evens before combining

Running a benchmark using the [benchmark-ips](http://rubygems.org/gems/benchmark-ips) gem:

```sh
$ ./examples.rb benchmark
ruby 3.0.5p211 (2022-11-24 revision ba5cf0f7c5) [arm64-darwin23]
Warming up --------------------------------------
          chatgpt_a   235.000 i/100ms
chat_gpt_a_optimised   533.000 i/100ms
          deepseek_a   503.000 i/100ms
Calculating -------------------------------------
          chatgpt_a      2.338k (± 0.3%) i/s  (427.68 μs/i) -     11.750k in   5.025343s
chat_gpt_a_optimised      5.298k (± 0.9%) i/s  (188.75 μs/i) -     26.650k in   5.030606s
          deepseek_a      5.118k (± 0.5%) i/s  (195.41 μs/i) -     25.653k in   5.012864s

Comparison:
chat_gpt_a_optimised:     5298.0 i/s
          deepseek_a:     5117.6 i/s - 1.04x  slower
          chatgpt_a:     2338.2 i/s - 2.27x  slower
```

Conclusion:

* the ChatGPT optimisation using partition is a great improvement over its initial attempt.
* deepseek got close right off the bat, but clearly `partition` is a little more efficient that `select`

### ChatGPT Revised (B)

I wonder if I can get ChatGPT to be a little less self-confident?!

Let's add an instruction to "Ask me questions if you are not 95% confident."
Here's the full prompt:

> What is the best way to interpret the following requirement, and how would you reduce this to an algorithm and implementation in ruby.
> Ask me questions if you are not 95% confident.
> The requirement, with examples: "Given two arrays, return all pairs (where each number is in each array) whose sum is an odd number."
>
> Examples:
>
> oddSum([9, 14, 6, 2, 11], [8, 4, 7, 20])
>
> => [9, 20], [14, 7], [11,8]
>
> oddSum([2, 4, 6, 8], [10, 12, 14])
>
> => null // (or whatever falsy value you prefer)

### ChatGPT Revised (B) Response

Thanks for the detailed prompt and examples. Here's how I'd approach interpreting and implementing it — and I’ll flag a couple of assumptions to confirm before writing code.

---

### ✅ Interpretation (based on examples and phrasing)

**Requirement:**
Given two arrays of integers, return *all unique pairs* `[a, b]` where:

* `a` is from the **first array**
* `b` is from the **second array**
* `a + b` is **odd**

### ❓Assumptions to Confirm

1. **Pairs are order-sensitive?**
   From the examples, `[9, 20]` appears instead of `[20, 9]`, so I assume **`[a, b]` should always have `a` from array 1 and `b` from array 2**, i.e., order matters.

2. **Duplicates allowed?**
   If the input arrays contain duplicates, should the result include multiple copies of the same logical pair?

   E.g., should this:

   ```ruby
   oddSum([2, 3], [3, 4])
   ```

   yield:

   ```ruby
   [3, 4], [2, 3]
   ```

   or filter to unique pairs?

3. **Return type when no results?**
   Is `nil` the preferred falsy return value, or would you prefer `[]` (empty array)? Ruby tends to prefer `[]` for empty results unless nil has semantic value.

---

### 💡 Observations (to reduce to algorithm)

* Odd sum ⇔ One number is even, the other is odd.
* Therefore, for a pair `(a, b)` to be odd:

    * `a.odd? && b.even?`
    * or `a.even? && b.odd?`

So we could:

1. Iterate through array A.
2. For each `a`, iterate through array B.
3. Keep `[a, b]` if the sum is odd.

This is an O(n \* m) algorithm.

---

### ✅ Implementation Plan in Ruby

```ruby
def odd_sum(array1, array2)
  result = []

  array1.each do |a|
    array2.each do |b|
      result << [a, b] if (a + b).odd?
    end
  end

  result.empty? ? nil : result
end
```

---

### 🔄 Example Usage

```ruby
odd_sum([9, 14, 6, 2, 11], [8, 4, 7, 20])
# => [[9, 20], [14, 7], [11, 8]]

odd_sum([2, 4, 6, 8], [10, 12, 14])
# => nil
```

---

Let me know:

* Should duplicates be filtered?
* Would you prefer to return `[]` instead of `nil` for no matches?
* Any constraints on input (e.g., always integers)?

Once you confirm, I can optimize or extend this (e.g., for larger data sets, use filtering by parity buckets for O(n + m) time).

### ChatGPT Revised (B) Result

So how did it do?

Well, it tried. It identified 3 possible ambiguities:

* Pairs are order-sensitive? Yes, this is a valid clarification
* Duplicates allowed? Another valid concern, however the explanation and example it provides is unclear and incorrect
* Return type when no results? Yes, another concern, though nothing surprising as it is mentioned in the question

But it has missed the issue of whether each element may only be used once,
and again incorrectly states that the code with produce the example provided.

## Conclusions

In general, generative AIs can easily stumble over poorly expressed requirements, so care is required.

* deepseek is actually quite good at identifying ambiguity and internal-contradictions in the prompt (requirements) it is given, even without explicit instruction. It will surface these issues in its response.
* ChatGPT is particularly bad at dealing with these issues, even when instructed to ask for clarifications if needed

## Example Code

See the code in [examples.rb](./examples.rb)
and simple test suite to match [test_examples.rb](./test_examples.rb).

```sh
$ ./test_examples.rb
Run options: --seed 35222

# Running:

......

Finished in 0.000285s, 21052.6316 runs/s, 21052.6316 assertions/s.

6 runs, 6 assertions, 0 failures, 0 errors, 0 skips
```

Here is [examples.rb](./examples.rb):

```ruby
#!/usr/bin/env ruby

require 'benchmark/ips'

class OddSumCalculator
  attr_accessor :arr1, :arr2

  def initialize(arr1, arr2)
    self.arr1 = arr1
    self.arr2 = arr2
  end

  def chat_gpt_a
    result = []

    arr1.each do |a|
      arr2.each do |b|
        result << [a, b] if (a + b).odd?
      end
    end

    result.empty? ? nil : result
  end

  def chat_gpt_a_optimised
    # Partition arr1
    odds1, evens1 = arr1.partition(&:odd?)
    # Partition arr2
    odds2, evens2 = arr2.partition(&:odd?)

    result = []

    # Add pairs: odd from arr1 + even from arr2
    odds1.each do |a|
      evens2.each do |b|
        result << [a, b]
      end
    end

    # Add pairs: even from arr1 + odd from arr2
    evens1.each do |a|
      odds2.each do |b|
        result << [a, b]
      end
    end

    result.empty? ? nil : result
  end

  def deepseek_a
    evens1 = arr1.select(&:even?)
    odds1  = arr1.select(&:odd?)
    evens2 = arr2.select(&:even?)
    odds2  = arr2.select(&:odd?)

    pairs = []
    evens1.each { |e| odds2.each { |o| pairs << [e, o] } }
    odds1.each { |o| evens2.each { |e| pairs << [o, e] } }

    pairs.empty? ? nil : pairs
  end

  def benchmark
    n = 100
    self.arr1 = Array.new(n) { |i| rand(1_000_000) }
    self.arr2 = Array.new(n) { |i| rand(1_000_000) }

    Benchmark.ips do |x|
      x.report('chatgpt_a') do
        chat_gpt_a
      end
      x.report('chat_gpt_a_optimised') do
        chat_gpt_a_optimised
      end
      x.report('deepseek_a') do
        deepseek_a
      end
      x.compare!
    end
  end
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} <algorithm> (csv-array-1) (csv-array-1)"; exit) unless ARGV.length > 0
  algorithm = ARGV[0]
  if algorithm == 'benchmark'
    OddSumCalculator.new([], []).benchmark
  else
    arr1 = ARGV[1] ? ARGV[1].split(',').map(&:to_i) : [1, 2, 3]
    arr2 = ARGV[2] ? ARGV[2].split(',').map(&:to_i) : [4, 5, 6]
    puts "Using algorithm: #{algorithm}"
    calculator = OddSumCalculator.new(arr1, arr2)
    puts "Array 1: #{calculator.arr1.inspect}"
    puts "Array 2: #{calculator.arr2.inspect}"
    puts "Result: #{calculator.send(algorithm).inspect}"
  end
end
```

## Credits and References

* <https://buttondown.com/cassidoo/archive/false-expectations-take-away-joy-sandra-bullock/>
* <https://andycroll.com/ruby/cassidoo-odd_sum-programming-exercise/>
* <https://andycroll.com/ruby/benchmarking-odd_sum/>
* <https://andycroll.com/ruby/further-options-odd_sum-with-benchmarking/>
* <https://chatgpt.com/>
* <https://chat.deepseek.com/>
