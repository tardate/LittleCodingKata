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

describe "if shortcuts" do
  it "is possible to do it the long way" do
    n = 44
    if n.even?
      description = "Very even!"
    else
      description = "A little odd!"
    end
    expect(description).to match(/even/)
  end

  it "is possible to do it with a ternary operator" do
    n = 43
    description = n.even? ? "Very even!" : "A little odd!"
    expect(description).to match(/odd/)
  end
end

def first_name_unless(value)
  @first_name = value
  @first_name = "" unless @first_name
end

def first_name_or_eq(value)
  @first_name = value
  @first_name ||= ""
end

def first_name_eq_or(value)
  @first_name = value
  @first_name = @first_name || ""
end

describe "or_eq_basics" do
  it "just works" do
    count = 1
    count += 1
    count = count + 1
    expect(count).to eq(3)
  end

  shared_examples "default first name" do |method_name|
    it "sets a nil first_name to an empty string" do
      self.send(method_name, nil)
      expect(@first_name).to eq("")
    end

    it "sets leaves other first_name values alone" do
      self.send(method_name, "Brandon")
      expect(@first_name).to eq("Brandon")
    end
  end

  describe "or_eq" do
    include_examples "default first name", :first_name_unless
    include_examples "default first name", :first_name_or_eq
    include_examples "default first name", :first_name_eq_or
  end
end

describe "safe navigation operator" do
  it "saves you from nil related exceptions" do
    myfile = nil
    expect do
      # Keep your fingers crossed that myfile is not nil!

      line = myfile.readline
    end.to raise_error(NoMethodError)
  end

  it "replaces long if expressions" do
    myfile = nil
    # Safer but a bit long.

    if myfile
      line = myfile.readline
    else
      line = nil
    end
    expect(line).to be_nil
  end

  it "replaces && expressions" do
    myfile = nil
    # Safer and shorter

    line = myfile && myfile.readline
    expect(line).to be_nil
  end

  it "can also replace ternary expressions" do
    myfile = nil
    # Better!
    #
    line = myfile ? myfile.readline : nil
    expect(line).to be_nil
  end

  it "is the soul of brevity" do
    myfile = nil
    # Even better!
    #
    line = myfile&.readline
    expect(line).to be_nil
  end

  def reverse_the_first_word_of_the_first_doc(docs)
    # Technically, if we have a document then words will never be nil.
    # But we are on a roll here.

    docs&.first&.words&.first&.reverse
  end

  it "is the soul of brevity" do
    docs = nil
    expect(reverse_the_first_word_of_the_first_doc(docs)).to be_nil
    docs = []
    expect(reverse_the_first_word_of_the_first_doc(docs)).to be_nil
    doc = Document.new(author: "russ", title: "test", content: "")
    expect(reverse_the_first_word_of_the_first_doc([doc])).to be_nil
    doc.content = "The rain in spain"
    expect(reverse_the_first_word_of_the_first_doc([doc])).to eq("ehT")
  end

  it "checks explicitly for nil" do
    expect(
      (1 == 0)&.to_s
    ).to eq("false")
  end
end
