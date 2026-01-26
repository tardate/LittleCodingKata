#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "case_examples"

describe "basic_case" do
  it "produces the output we expect" do
    expect { basic_case("Jaws") }.to output(/Don.t k/).to_stdout
    expect { basic_case("War And Peace") }.to output(/Tolstoy/).to_stdout
  end
end

shared_examples "returns author" do |method_name|
  it "prints correctly with the given method" do
    expect(self.send(method_name, "War And Peace")).to match(/Tolstoy/)
    expect(self.send(method_name, "Romeo And Juliet")).to match(/Shakespeare/)
  end
end

describe "value_returned" do
  include_examples "returns author", :value_returned

  it "returns a string for an unrecognized title" do
    expect(value_returned("Jaws")).to match(/Don.t k/)
  end
end

describe "more_compact" do
  include_examples "returns author", :more_compact

  it "returns a string for an unrecognized title" do
    expect(more_compact("Jaws")).to match(/Don.t k/)
  end
end

describe "nil_no_match" do
  include_examples "returns author", :nil_no_match
  it "returns nil if there is no match" do
    expect(nil_no_match("Jaws")).to be_nil
  end
end

describe "case_classes" do
  let(:doc) { Document.new(title: "Test", author: "Russ", content: "aa bb cc") }

  it "returns the values we expect" do
    expect { case_classes(doc) }.to output(/It.*document/).to_stdout
    expect { case_classes("hello") }.to output(/It.*string/).to_stdout
    expect { case_classes(42) }.to output(/Don.t know/).to_stdout
  end
end

describe "case_re" do
  it "returns the values we expect" do
    expect{ case_re("War And Peace") }.to output(/Tolstoy/).to_stdout
    expect{case_re("Romeo And Juliet")}.to output(/Shakespeare/).to_stdout
    expect{case_re("The Martian")}.to output(/no idea/).to_stdout
  end
end

describe "case_conditions" do
  it "returns the values we expect" do
    expect{ case_conditions("War And Peace") }.to output(/Tolstoy/).to_stdout
    expect{ case_conditions("Romeo And Juliet") }.to output(/Shakespeare/).to_stdout
    expect{ case_conditions("The Martian") }.to output(/no idea/).to_stdout
  end
end
