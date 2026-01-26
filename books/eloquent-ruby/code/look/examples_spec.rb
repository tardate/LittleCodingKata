#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "examples"

describe "Inline comment examples" do
  it "computes total energy" do
    expect(compute_total_energy(1, 1, 1, 1)).to be_within(0.001).of(1.5)
    expect(compute_total_energy(2, 1, 1, 1)).to be_within(0.001).of(3.0)
    expect(compute_total_energy(1, 2, 1, 1)).to be_within(0.001).of(3.0)
    expect(compute_total_energy(1, 4, 1, 1)).to be_within(0.001).of(9.0)
    expect(compute_total_energy(1, 1, 2, 1)).to be_within(0.001).of(2.5)
    expect(compute_total_energy(1, 1, 1, 2)).to be_within(0.001).of(2.5)
  end

  it "can increment" do
    expect(increment(0)).to eq(1)
    expect(increment(999)).to eq(1000)
  end
end

describe "Name examples" do
  it "has a working method" do
    expect(count_words_in("hello out there")).to eq(3)
  end

  it "has a working moose example" do
    expect(ANTLERS_PER_MALE_MOOSE).to eq(2)
  end
end

describe "puts examples" do
  it "prints what we expect" do
    expect { puts_without_parens }.to output(/Look Ma/).to_stdout
  end
end

shared_examples "word method" do |doc_class|
  let(:doc) { doc_class.new(title: "Test", author: "Russ", content: "aa bb cc") }

  it "returns an array of words" do
    expect(doc.words).to eq(%w{aa bb cc})
  end
end

describe DocNoParens do
    include_examples "word method", DocNoParens
end

describe DocParens do
    include_examples "word method", DocParens
end

describe "if statement" do
  let(:short_array) { %w{the worst of times} }
  let(:long_array) { ["hello"] * 200 }

  it "works with parens" do
    expect{if_with_parens(short_array)}.to  output(/not very long/).to_stdout
    expect{if_with_parens(long_array)}.to  output("").to_stdout
  end

  it "works with parens" do
    expect{if_without_parens(short_array)}.to  output(/not very long/).to_stdout
    expect{if_without_parens(long_array)}.to  output("").to_stdout
  end
end

describe "folded line example" do
  it "lets you put 2 statements on a line" do
    expect { multiple_statements }.to output("Emma\nAusten\n").to_stdout
  end
end

describe "Short method syntax examples" do
  it "lets you define a one line method with a semicolon" do
    expect{multiple_statements}.to output("Emma\nAusten\n").to_stdout
  end

  it "lets you define a trivial class on one line" do
    expect(DocumentException.new).to be_kind_of(Exception)
  end

  it "lets you define a one line method with a semicolon" do
    expect(a_trivial_method).to be_nil
  end

  it "lets you define a one line method without a semicolon" do
    expect(another_trivial_method(title: "Emma", author: "Austen")).to be_nil
  end

  it "lets you define a endless method" do
   expect(add_two(7)).to eq(9)
  end
end

describe "brace block example" do
  it "outputs what we expect" do
    expect { brace_block }.to output(/The number is 9/).to_stdout
  end
end

describe "do end block example" do
  it "outputs what we expect" do
    expect{do_end_block}.to output(/The number is 9/).to_stdout
    expect{do_end_block}.to output(/Twice the number is 18/).to_stdout
  end
end

describe "practical block variations" do
  let(:doc) { Document.new(title: "Test", author: "Russ", content: "aa bb cc") }

  it "do_end_words outputs what we expect" do
    expect{ do_end_words doc }.to output("aa\nbb\ncc\n").to_stdout
  end

  it "braces_words outputs what we expect" do
    expect{ do_end_words doc }.to output("aa\nbb\ncc\n").to_stdout
  end

    it "block_with_long_expression outputs what we expect" do
    expect{ do_end_words doc }.to output("aa\nbb\ncc\n").to_stdout
  end
end

describe "practical paren variations" do
  let(:doc) { Document.new(title: "Test", author: "Russ", content: "aa bb cc") }

  it "has a working simple_is_a? method" do
    expect{ simple_is_a?(doc) }.to output("true\n").to_stdout
    expect{ simple_is_a?(444) }.to output("false\n").to_stdout
  end

  it "has a working complex_is_a? method" do
    expect{ complex_is_a?(doc) }.to output("true\n").to_stdout
    expect{ complex_is_a?(444) }.to output("false\n").to_stdout
  end

  it "has a working better_complex_is_a? method" do
    expect{ better_complex_is_a?(doc) }.to output("true\n").to_stdout
    expect{ better_complex_is_a?(444) }.to output("false\n").to_stdout
  end
end
