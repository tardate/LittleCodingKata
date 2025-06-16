# #335 The Odd-sum Epic

Cassidy Williams recently featured a ruby coding challenge that spurred a lively discussion of algorithms, and a general marvelling at the loveliness of ruby's Enumerable class. There was however a bit of a requirements trap in the question, not uncommon IRL, but it had me wondering how well generative AI would cope. I put ChatGPT and Deepseek to the test, and the results are in!

## Notes

The
[interview question of the week (2025-05-26)](https://buttondown.com/cassidoo/archive/false-expectations-take-away-joy-sandra-bullock/)
stirred up some wonderful discussion and coding:

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

I first came across the challenge when I saw
Andy Croll's post on the subject:
[Further Performance Testing Enumerable’s Loveliness](https://andycroll.com/ruby/further-options-odd_sum-with-benchmarking/).

As all the good work on algorithms and performance seem to have already been hammered out, my attention was drawn elsewhere.

I'd immediately noticed something off in first example provided:
`[9, 20], [14, 7], [11,8]`.
It apparently implies that each element can only be paired once with an element from the other array.

The written requirement asks for all pairs, perhaps implying all possible pairs that add to an odd number should be returned. This is the interpretation that most people seem to have gone with.
Under these rules, the expected pairs would be:
`[9, 8], [9, 4], [9, 20], [14, 7], [6, 7], [2, 7], [11, 8], [11, 4], [11, 20]`

This is a classic demonstration of written requirements being in conflict with examples provided. As the requirements analyst, your job is to figure out if the examples are just wrong, or if they actually convey additional important details and clarifications of the requirement.

Throughout my career, I can honestly say this is less the exception, than the rule. It is simple human nature that many people will confidently state "THIS is my requirement" and then give half a dozen examples that contradict the requirement to one degree or another.

So what is one to do?
I've never found a better solution than simply to ask more questions! It is easy. There is no general rule for whether words should trump examples or vice versa.

It makes me wonder how well AI handles this common human confusion.

In the following sections I put ChatGPT and Deepseek to the test, compare their solutions with others I have seen posted, and look at resolving the requirements/examples conflict.

### The TLDR

* In general, generative AIs can easily stumble over poorly expressed requirements, so care is required.
    * Deepseek is actually quite good at identifying ambiguity and internal-contradictions in the prompt (requirements) it is given, even without explicit instruction. It will surface these issues in its response.
    * ChatGPT is particularly bad at dealing with these issues, even when instructed to ask for clarifications
* None of the AI solutions (or other's I've seen posted) reproduce the example results included in the problem statement. All prefer to go with the written requirement instead and ignore the contradictory example.
* I present a solution that does produce results matching the examples
    * It required a number of additional assumptions, all worthy of additional clarification
    * So if this was a real-world coding problem, I would say we are far from done yet!

In summary, there are two clear lessons I take away from this most interesting exercise:

* There is no substitute (yet) for human conversations to clarify and refine requirements
* But AI can code the solution and get you to optimal implementations with minimal effort ... once the requirement is clearly understood

Ah, the lost art of requirements analysis!

### AI On the Job

So how well does AI handle this common human confusion?

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

No hesitation here... ChatGPT is confident it got this right, right off the bat. Let's see!

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
* deepseek got close with its first suggestion, but clearly `partition` is a little more efficient that `select`

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

## How did Andy Do It?

It was Andy Croll's post on
[Enumerable’s loveliness](https://andycroll.com/ruby/cassidoo-odd_sum-programming-exercise/)
that first clued me into this interesting programming challenge.

He'd also had quite a discussion online about refining the algorithms.
The following are the three main variations that he came up with.

The first (intentionally naïve) approach was essentially the same as ChatGPT's first attempt, except using the mod trick to calculate parity instead of the `odd?` method.

```ruby
results = []
a.each do |x|
  b.each do |y|
    if ((x + y) % 2) == 1
      results << [x, y]
    end
  end
end
results
```

Calling this `andy_a` and it works just fine :

```sh
$ ./examples.rb andy_a "9, 14, 6, 2, 11" "8, 4, 7, 20"
Using algorithm: andy_a
Array 1: [9, 14, 6, 2, 11]
Array 2: [8, 4, 7, 20]
Result: [[9, 8], [9, 4], [9, 20], [14, 7], [6, 7], [2, 7], [11, 8], [11, 4], [11, 20]]
```

The second approach `andy_b` used Enumerable's product method to reduce to a one-liner. This is similar to the approach that Deepseek came up with.

```ruby
(a.select(&:odd?).product(b.select(&:even?)) +
  b.select(&:odd?).product(a.select(&:even?)))
.uniq
```

It basically works, however it reverses pairs that have an even number from array a and an odd number from array b:

```sh
$ ./examples.rb andy_b "9, 14, 6, 2, 11" "8, 4, 7, 20"
Using algorithm: andy_b
Array 1: [9, 14, 6, 2, 11]
Array 2: [8, 4, 7, 20]
Result: [[9, 8], [9, 4], [9, 20], [11, 8], [11, 4], [11, 20], [7, 14], [7, 6], [7, 2]]
```

We can easily fix that:

```ruby
(a.select(&:odd?).product(b.select(&:even?)) +
  a.select(&:even?).product(b.select(&:odd?)))
.uniq
```

Calling this `andy_a_fixed` and it works just fine :

```sh
$ ./examples.rb andy_b_fixed "9, 14, 6, 2, 11" "8, 4, 7, 20"
Using algorithm: andy_b_fixed
Array 1: [9, 14, 6, 2, 11]
Array 2: [8, 4, 7, 20]
Result: [[9, 8], [9, 4], [9, 20], [11, 8], [11, 4], [11, 20], [14, 7], [6, 7], [2, 7]]
```

The third approach does a product then select rather than the reverse, making for a much more compact solution. I didn't get this suggested by any of the AI solutions.

```ruby
a.product(b).select { (_1 + _2).odd? }.uniq
```

Calling this `andy_c` and it works just fine :

```sh
$ ./examples.rb andy_c "9, 14, 6, 2, 11" "8, 4, 7, 20"
Using algorithm: andy_c
Array 1: [9, 14, 6, 2, 11]
Array 2: [8, 4, 7, 20]
Result: [[9, 8], [9, 4], [9, 20], [14, 7], [6, 7], [2, 7], [11, 8], [11, 4], [11, 20]]
```

The final approach used `partition`, this is quite similar to the ChatGPT optimised approach (`chat_gpt_a_optimised`):

```ruby
odd_as, even_as = a.partition(&:odd?)
odd_bs, even_bs = b.partition(&:odd?)
(odd_as.product(even_bs) + odd_bs.product(even_as)).uniq
```

Calling this `andy_d`; and obviously it has the same pair-reversal issue as `andy_b`:

```sh
$ ./examples.rb andy_d "9, 14, 6, 2, 11" "8, 4, 7, 20"
Using algorithm: andy_d
Array 1: [9, 14, 6, 2, 11]
Array 2: [8, 4, 7, 20]
Result: [[9, 8], [9, 4], [9, 20], [11, 8], [11, 4], [11, 20], [7, 14], [7, 6], [7, 2]]
```

So fixing that:

```ruby
odd_as, even_as = a.partition(&:odd?)
odd_bs, even_bs = b.partition(&:odd?)
(odd_as.product(even_bs) + even_as.product(odd_bs)).uniq
```

Calling this `andy_d_fixed` and it works just fine :

```sh
$ ./examples.rb andy_d_fixed "9, 14, 6, 2, 11" "8, 4, 7, 20"
Using algorithm: andy_d_fixed
Array 1: [9, 14, 6, 2, 11]
Array 2: [8, 4, 7, 20]
Result: [[9, 8], [9, 4], [9, 20], [11, 8], [11, 4], [11, 20], [14, 7], [6, 7], [2, 7]]
```

When Andy [benchmarked the solutions](https://andycroll.com/ruby/further-options-odd_sum-with-benchmarking/),
it became obvious that the `product` method was a significant issue especially as the array sizes increased in the order of O(n²), but the `partition` solution came out tops.
So let's add `andy_d_fixed` to the benchmark:

```sh
$ ./examples.rb benchmark
ruby 3.0.5p211 (2022-11-24 revision ba5cf0f7c5) [arm64-darwin23]
Warming up --------------------------------------
           chatgpt_a   236.000 i/100ms
chat_gpt_a_optimised   527.000 i/100ms
          deepseek_a   520.000 i/100ms
        andy_d_fixed   121.000 i/100ms
Calculating -------------------------------------
           chatgpt_a      2.367k (± 0.4%) i/s  (422.49 μs/i) -     12.036k in   5.085205s
chat_gpt_a_optimised      5.331k (± 0.9%) i/s  (187.58 μs/i) -     26.877k in   5.042026s
          deepseek_a      5.081k (± 3.9%) i/s  (196.82 μs/i) -     25.480k in   5.025086s
        andy_d_fixed      1.195k (± 2.8%) i/s  (837.07 μs/i) -      6.050k in   5.069185s

Comparison:
chat_gpt_a_optimised:     5331.0 i/s
          deepseek_a:     5080.8 i/s - 1.05x  slower
           chatgpt_a:     2366.9 i/s - 2.25x  slower
        andy_d_fixed:     1194.6 i/s - 4.46x  slower
```

While `chat_gpt_a_optimised` and `andy_d_fixed` are quite similar in approach,
the ChatGPT approach is getting a huge edge in performance:

* both use partition to split odds and evens
* but `andy_d_fixed` then uses uniq over product to reduce the options
* this is failing to perform at scale compared to the `chat_gpt_a_optimised` which simply iterates and appends the valid combinations of odd+even/even+odd.

## What if the Examples were correct after all?

All the solutions so far have assumed the words of the requirement are correct, and the first example is just wrong or misleading.

But what if it isn't? What if upon further clarification, your "customer" said

> No, the example is correct. The numbers can only be used once.
> That's what my requirement says obviously!!

So all the solutions above are wrong;-)

As a quick detour into this alternate universe,
let's take `chat_gpt_a_optimised` - the best (fastest) solution so far -
and modify it to comply with the clarified requirement:

```ruby
odds1, evens1 = arr1.partition(&:odd?)
odds2, evens2 = arr2.partition(&:odd?)
result = []

evens2.sort!
odds2.sort!

odds1.each do |a|
  b = evens2.pop
  result << [a, b] if b
end

evens1.each do |a|
  b = odds2.pop
  result << [a, b] if b
end

result.empty? ? nil : result
```

Let's call this `examples_rule`, and yes, it reproduces the given example result exactly.
Note that a couple of tricks were required:

* items from array A are processed from front to back,
    * while items from array B are processed from back to front (using `pop` instead of `shift`)
* items in array B are sorted, so they are consumed in the same order shown in the example

These points are all worthy of additional clarification, so if this was a real-world coding problem, I would say we are far from done yet.

```sh
$ ./examples.rb examples_rule "9, 14, 6, 2, 11" "8, 4, 7, 20"
Using algorithm: examples_rule
Array 1: [9, 14, 6, 2, 11]
Array 2: [8, 4, 7, 20]
Result: [[9, 20], [11, 8], [14, 7]]
```

## Conclusions

* In general, generative AIs can easily stumble over poorly expressed requirements, so care is required.
    * Deepseek is actually quite good at identifying ambiguity and internal-contradictions in the prompt (requirements) it is given, even without explicit instruction. It will surface these issues in its response.
    * ChatGPT is particularly bad at dealing with these issues, even when instructed to ask for clarifications
* None of the AI solutions (or other's I've seen posted) reproduce the example results included in the problem statement. All prefer to go with the written requirement instead and ignore the contradictory example.
* I present a solution that does produce results matching the examples
    * It required a number of additional assumptions, all worthy of additional clarification
    * So if this was a real-world coding problem, I would say we are far from done yet!

In summary, there are two clear lessons I take away from this most interesting exercise:

* There is no substitute (yet) for human conversations to clarify and refine requirements
* But AI can code the solution and get you to optimal implementations with minimal effort ... once the requirement is clearly understood

Ah, the lost art of requirements analysis!

## Example Code

See the code in [examples.rb](./examples.rb)
and a simple test suite to match [test_examples.rb](./test_examples.rb).

```sh
$ ./test_examples.rb
Run options: --seed 63321

# Running:

.......S......S.....

Finished in 0.000493s, 40567.9513 runs/s, 36511.1562 assertions/s.

20 runs, 18 assertions, 0 failures, 0 errors, 2 skips

You have skipped tests. Run with --verbose for details.
```

Here is [examples.rb](./examples.rb) in full:

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

  def andy_a
    a = arr1
    b = arr2
    results = []
    a.each do |x|
      b.each do |y|
        if ((x + y) % 2) == 1
          results << [x, y]
        end
      end
    end
    results
  end

  def andy_b
    a = arr1
    b = arr2
    (a.select(&:odd?).product(b.select(&:even?)) +
      b.select(&:odd?).product(a.select(&:even?)))
    .uniq
  end

  def andy_b_fixed
    a = arr1
    b = arr2
    (a.select(&:odd?).product(b.select(&:even?)) +
      a.select(&:even?).product(b.select(&:odd?)))
    .uniq
  end

  def andy_c
    a = arr1
    b = arr2
    a.product(b).select { (_1 + _2).odd? }.uniq
  end

  def andy_d
    a = arr1
    b = arr2
    odd_as, even_as = a.partition(&:odd?)
    odd_bs, even_bs = b.partition(&:odd?)
    (odd_as.product(even_bs) + odd_bs.product(even_as)).uniq
  end

  def andy_d_fixed
    a = arr1
    b = arr2
    odd_as, even_as = a.partition(&:odd?)
    odd_bs, even_bs = b.partition(&:odd?)
    (odd_as.product(even_bs) + even_as.product(odd_bs)).uniq
  end

  def examples_rule
    odds1, evens1 = arr1.partition(&:odd?)
    odds2, evens2 = arr2.partition(&:odd?)
    result = []

    evens2.sort!
    odds2.sort!

    odds1.each do |a|
      b = evens2.pop
      result << [a, b] if b
    end

    evens1.each do |a|
      b = odds2.pop
      result << [a, b] if b
    end

    result.empty? ? nil : result
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
      x.report('andy_d_fixed') do
        andy_d_fixed
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
* [The Illusion of Thinking: Understanding the Strengths and Limitations of Reasoning Models via the Lens of Problem Complexity](https://machinelearning.apple.com/research/illusion-of-thinking)
