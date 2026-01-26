#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

class WithoutEnumerable
  def each(&block)
    [1,2,3].each &block
  end
end

class WithEnumerable
  include Enumerable

  def each(&block)
    [1,2,3].each &block
  end
end

describe WithoutEnumerable do
  it "has a valid each method" do
    expect do
      WithoutEnumerable.new.each { |x| puts x }
    end.to output(/1\n2\n3\n/m).to_stdout
  end
end

describe WithEnumerable do
  let(:we) { WithEnumerable.new }

  it "has a valid each method" do
    expect do
      we.each { |x| puts x }
    end.to output(/1\n2\n3\n/m).to_stdout
  end

  it "has various Enumerable methods" do
    expect(we.count).to eq(3)
    expect(we.include?(3)).to be_truthy
    expect(we.include?(999)).to be_falsey
  end
end

describe "Number of methods added by Enumerable" do
  it "should be around 60" do
    n_without = WithoutEnumerable.public_instance_methods.count
    n_with = WithEnumerable.public_instance_methods.count
    diff = n_with - n_without
    expect(diff > 60)
  end
end

