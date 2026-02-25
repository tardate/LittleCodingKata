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
