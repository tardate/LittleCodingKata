#!/usr/bin/env lua

function reduce(max, init, f)
   local result = init
   for i = 1, max do
      result = f(result, i)
   end
   return result
end

function factorial(n)
  return reduce(n, 1, function(previous, next)
    return previous * next
  end)
end

local n = tonumber(arg[1])

if not n then
  print("Usage: lua factorial.lua [number]")
  os.exit(1)
end

print(factorial(n))
