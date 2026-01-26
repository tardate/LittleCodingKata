#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_authors"

module LoadFont
  def load_font(name:, size: 12)
    # Go font hunting...
    return [name, size]
  end
end

describe "load_font" do
  include LoadFont

  it "has a default size" do
    f = load_font(name: "small_font")
    expect(f).to eq(["small_font", 12])
  end

  it "lets you specify a size" do
    f = load_font(name: "big_font", size: 100)
    expect(f).to eq(["big_font", 100])
  end
end

module Echo
  def echo_all(*args)
    args.each { |arg| puts arg }
  end

  def echo_at_least_two(first_arg, *middle_args, last_arg)
    puts "The first argument is #{first_arg}"
    middle_args.each { |arg| puts "A middle argument is #{arg}" }
    puts "The last argument is #{last_arg}"
  end
end

describe "echo_all" do
  include Echo
  it "prints all of its arguments" do
    expect {echo_all}.to output("").to_stdout
    expect {echo_all 1, 2}.to output(/1.*2/m).to_stdout
  end
end

describe "echo_at_least_two" do
  include Echo
  it "prints all of 2-n arguments" do
    expect {echo_at_least_two}.to raise_error(ArgumentError) 
    expect {echo_at_least_two 1}.to raise_error(ArgumentError) 
    expect {echo_at_least_two 1, 2}.to output(/1.*2/m).to_stdout
    expect {echo_at_least_two 1, 2, 3, 4}.to output(/1.*2.*3.*4/m).to_stdout
  end
end

describe NoStar::Document do
  let(:doc) { it.new }
  it "lets you add authors in an array" do
    doc = NoStar::Document.new(author: "", title: "t", content: "c")
    doc.add_authors(["Strunk", "White"])
    expect(doc.author).to match(/Strunk.*White/)
  end
end

describe WithStar::Document do
  let(:doc) { it.new }
  it "lets you add authors in an array" do
    doc = WithStar::Document.new(author: "", title: "t", content: "c")
    doc.add_authors("Strunk", "White")
    expect(doc.author).to match(/Strunk.*White/)
  end
end

module LoadFontHash
  def load_font(font_specification:)
    # Load a font according to font_specification[:name] etc.
    font_specification
  end
end

describe "load_font" do
  include LoadFontHash
  it "works with braces" do
    specification = 
      load_font(font_specification: {name: "times roman", size: 12})
    expect(specification).to eq({name: "times roman", size: 12})
  end
end

module LoadFontAllKWs
  def load_font(**font_specification)
    # Load a font according to font_specification[:name] etc.
    font_specification
  end
end

describe "load font with kws" do
  include LoadFontAllKWs

  it "works with braces" do
    specification = 
      load_font(name: "times roman", size: 12)
    expect(specification).to eq({name: "times roman", size: 12})
  end
end
