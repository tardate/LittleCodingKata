#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe :times do
  it "iterates over the intergers" do
    expect do
      12.times { |x| puts "The number is #{x}" }
    end.to output(/The number.*1.*2.*11\n/m).to_stdout
  end
end
