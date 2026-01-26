#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "yard_logger"

describe YARD::Logger do
  METHODS = %i{debug error fatal info unknown warn}

  it "has the generated instance methods" do
    all_methods = METHODS.clone
    all_methods << :log
    expect(YARD::Logger.instance_methods(false)).to match_array(all_methods)
  end

  it "has logging methods that work" do
    logger = YARD::Logger.new

    METHODS.each do |m|
      expect do
        logger.send(m, "This is #{m} message")
      end.to output(/This is #{m} message/).to_stdout
    end
  end
end
