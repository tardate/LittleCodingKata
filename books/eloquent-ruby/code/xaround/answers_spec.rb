#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "answers"

describe "lastest with_logging" do
  it "returns the value produced by the block" do
    # The number is approximate, since the speed of light
    # is not exactly 300,000 km per second.
    expect(Answers.do_something_silly).to eq(9460800000000)
    expect { Answers.do_something_silly }.to output(/Starting.*Completed/m).to_stdout
  end
end

describe "dual_return" do
  it "returns the execution time and the value produced by the block" do
    result = Answers.time_execution { sleep(0.25); 1234 }
    expect(result[:execution_time]).to be >= 0.2499
    expect(result[:result]).to eq(1234)
  end
end


