#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# You need to install the prime gem for this to work.

require "prime"
  
# According to Euclid, there are infinitely many primes.
# But we will stop after they hit 1,000.
  
Prime.each do |x| 
  # But we will stop after a
  break if x > 1_000
  puts "The next prime is #{x}"
end
