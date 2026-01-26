#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# This is a simple program to demonstrate TracePoint.

def sum_to(n)
  sum = 0
  (n+1).times do |i|
    sum += i
  end
  sum
end


puts sum_to(5)
