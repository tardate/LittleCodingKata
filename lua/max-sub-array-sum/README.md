# #xxx maxSubarraySum

Using Lua to find the maximum sub-array sum; cassidoo's interview question of the week (2026-02-23).
Turns out that this is probably also a proof for the sunk cost fallacy!

## Notes

The [interview question of the week (2026-02-23)](https://buttondown.com/cassidoo/archive/change-but-start-slowly-because-direction-is-more/)
asks us to find the maximum sub-array sum:

> Given an array of integers, find the contiguous subarray that has the largest sum and return that sum. A subarray must contain at least one element. If all elements are negative, return the largest (least negative) value. If you need a hint, look up Kadane's Algorithm!
>
> Examples:
>
> ```ts
> > maxSubarraySum([-2, 1, -3, 4, -1, 2, 1, -5, 4])
> 6
> > maxSubarraySum([5])
> 5
> > maxSubarraySum([-1, -2, -3, -4])
> -1
> > maxSubarraySum([5, 4, -1, 7, 8])
> 23
> ```

## Thinking about the Problem

### Using Lua

See [LCK#417 About Lua](../about/) for my introduction to Lua.

I'm using a version installed with homebrew on macOS:

```sh
$ lua -v
Lua 5.4.8  Copyright (C) 1994-2025 Lua.org, PUC-Rio
```

### A First Go

This reminds me a little of [LCK#401 maxScoreWithOneReset](../../erlang/max-score-with-one-reset/), but without the constraint of only allowing one reset.

Here we basically get free resets, and what we want to avoid is going negative -
akin to the [sunk cost fallacy](https://en.wikipedia.org/wiki/Sunk_cost#Fallacy_effect).

Here's a first go - it basically resets the count whenever it gets worse than our current streak,
and `max_sum` tracks the best streak of all:

```lua
local function maxSubarraySum(arr)
  local max_sum = -math.huge
  local current_sum = 0

  for i = 1, #arr do
    current_sum = math.max(arr[i], current_sum + arr[i])
    max_sum = math.max(max_sum, current_sum)
  end

  return max_sum
end
```

Running some examples:

```sh
$ ./challenge.lua
Usage: lua challenge.lua [comma-separated numbers] or lua challenge.lua test
$ ./challenge.lua "-2, 1, -3, 4, -1, 2, 1, -5, 4"
6
$ ./challenge.lua 5
5
$ ./challenge.lua "-1, -2, -3, -4"
-1
$ ./challenge.lua "5, 4, -1, 7, 8"
23
```

And running the test suite:

```sh
$ ./challenge.lua test
All test cases passed!
```

### Example Code

Final code is in [challenge.lua](./challenge.lua):

```lua
#!/usr/bin/env lua

local function maxSubarraySum(arr)
  local max_sum = -math.huge
  local current_sum = 0

  for i = 1, #arr do
    current_sum = math.max(arr[i], current_sum + arr[i])
    max_sum = math.max(max_sum, current_sum)
  end

  return max_sum
end

local function testSuite()
  local test_cases = {
    {input = {-2, 1, -3, 4, -1, 2, 1, -5, 4}, expected = 6},
    {input = {5}, expected = 5},
    {input = {-1, -2, -3, -4}, expected = -1},
    {input = {5, 4, -1, 7, 8}, expected = 23},
  }

  for i, test in ipairs(test_cases) do
    local result = maxSubarraySum(test.input)
    assert(result == test.expected, string.format("Test case %d failed: expected %d, got %d", i, test.expected, result))
  end
  print("All test cases passed!")
end

local arg1 = arg[1]
if arg1 == "test" then
  testSuite()
elseif arg1 then
  local numbers = {}
  for num in arg1:gmatch("[^,]+") do
    table.insert(numbers, tonumber(num))
  end
  local result = maxSubarraySum(numbers)
  print(result)
else
  print("Usage: lua challenge.lua [comma-separated numbers] or lua challenge.lua test")
end

```

## Credits and References

* [cassidoo's interview question of the week (2026-02-23)](https://buttondown.com/cassidoo/archive/change-but-start-slowly-because-direction-is-more/)
* [LCK#417 About Lua](../about/)
* [Maximum Subarray Sum - Kadane's Algorithm](https://www.geeksforgeeks.org/dsa/largest-sum-contiguous-subarray/)
* <https://en.wikipedia.org/wiki/Sunk_cost#Fallacy_effect>
* [The Sunk Cost Fallacy explained](https://thedecisionlab.com/biases/the-sunk-cost-fallacy)
