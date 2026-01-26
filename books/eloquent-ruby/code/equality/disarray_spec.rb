#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "disarray"

describe DisArray do
  let(:da1) { DisArray.new([1,2,3,4]) }
  let(:da2) { DisArray.new([1,2,3,4]) }
  let(:da3) { DisArray.new([100,200]) }

  it "is == to similar versions of itself" do
    expect(da1 == da1).to be_truthy
    expect(da1 == da2).to be_truthy
    expect(da2 == da1).to be_truthy
  end

  it "is not == to dissimilar Disarray instances" do
    expect(da1 == da3).to be_falsey
    expect(da3 == da1).to be_falsey
  end

  it "is not == to random objects" do
    expect(da1 == 32).to be_falsey
    expect(da3 == false).to be_falsey
  end

  it "is eql? to similar versions of itself" do
    expect(da1.eql? da1).to be_truthy
    expect(da1.eql? da2).to be_truthy
    expect(da2.eql? da1).to be_truthy
  end

  it "is not eql? to dissimilar Disarray instances" do
    expect(da1.eql? da3).to be_falsey
    expect(da3.eql? da1).to be_falsey
  end

  it "is not eql? to random objects" do
    expect(da1.eql? 32).to be_falsey
    expect(da3.eql? false).to be_falsey
  end

  it "has the same hash as similar versions of itself" do
    expect(da1.hash == da1.hash).to be_truthy
    expect(da1.hash == da2.hash).to be_truthy
    expect(da2.hash == da1.hash).to be_truthy
  end

  it "has a different hash from dissimilar Disarray instances" do
    expect(da1.hash == da3.hash).to be_falsey
    expect(da3.hash == da1.hash).to be_falsey
  end

  it "has a different hash from to random objects" do
    expect(da1.hash == 32.hash).to be_falsey
    expect(da3.hash == false.hash).to be_falsey
  end
end
