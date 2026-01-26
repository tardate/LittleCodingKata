#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "a Ruby string" do
  it "support each_char" do
    expected = File.read("#{__dir__}/clarke_chars.txt")
    @author = "Clarke"
    expect {
      @author.each_char { |c| puts c }
    }.to output(expected).to_stdout
  end

  it "support each_byte" do
    expected = File.read("#{__dir__}/clarke_bytes.txt")
    @author = "Clarke"
    expect {
      @author.each_byte { |b| puts b }
    }.to output(expected).to_stdout
  end

  it "does not have an each method" do
    expect do
      "abc".each {|something| something}
    end.to raise_exception(NoMethodError)
  end

  it "has an each_line method" do
    @content = "aaa\bbb\ccc\n"
    expect do
      @content.each_line { |line| puts line }
    end.to output(@content).to_stdout
  end
end
