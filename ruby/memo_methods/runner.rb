# Common setup for running the example tests

require 'benchmark'

# The function we'll memoize
def factorial(n)
  return 1 if n == 0
  return factorial(n - 1) * n
end

# Main wrapper
def run
  unless ARGV.length == 2
    puts "Usage: ruby #{$0} number_of_times_to_calc_factorial factorial_to_calc";
    puts "  e.g. ruby #{$0} 10000 200\n\n";
    exit
  end

  runs = ARGV.shift.to_i
  factorial_number = ARGV.shift.to_i

  expected_result = factorial(factorial_number)

  Benchmark.bm(11) do |bm|
    bm.report("without memoize") { runs.times { raise 'result has unexpectedly changed' unless factorial(factorial_number) == expected_result } }
    memoize :factorial
    bm.report("with memoize") { runs.times { raise 'result has unexpectedly changed' unless factorial(factorial_number) == expected_result } }
  end
end
