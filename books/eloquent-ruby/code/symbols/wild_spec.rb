#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "../common/document"

class Book < Document; end

describe Symbol do
  it "differs in intent from strings" do
    titles_output = 
    ["Emma\n", "War & Peace\n", "Jaws\n"]
    expect(
      File.readlines("titles.txt") 
    ).to eq(titles_output)
  end

  it "is how method names are represented" do
    code = Proc.new do
      obj =
      Object.new.methods
    end
    result = code.call
    expect(result).to be_kind_of(Array)
    expect(result.length).to be > 20
    expect(result.all? { |o| o.is_a? Symbol }).to be_truthy
  end

  it "should be used as the result of defined?" do
    name = "Rory"
    PI = 3.14159
    

    expect(
    defined?(name)              # "local-variable", a string!
    ).to eq("local-variable")

    expect(
    defined?(PI)                # "constant", another string!
    ).to eq("constant")

    expect(
    defined?(a_random_name)     # nil
    ).to be_nil
  end
end
