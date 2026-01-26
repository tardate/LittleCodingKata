#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require "fileutils"
require_relative "text_compressor"
require_relative "better_compressor"
require_relative "best_compressor"
require_relative "private_compressor"
require_relative "troubled_compressor"

shared_examples "text compressor" do 
  let(:indices) do
    [0, 1, 2, 3, 1, 4, 5, 1]
  end

  let(:all_words) do
    ["This", "specification", "is", "the", "for", "a"]
  end

  it "computes the correct indexes and word array" do
    unique_word_array = compressor.unique
    word_index = compressor.index
    expect(word_index).to eq(indices)
    expect(unique_word_array).to eq(all_words)
  end
end

module BasicCompressor
  describe TextCompressor do
    let(:compressor) do
      text = "This specification is the specification for a specification"
      compressor = TextCompressor.new(text: text)
      compressor
    end

    include_examples "text compressor"
  end
end

module BetterCompressor
  describe TextCompressor do
    let(:compressor) do
      text = "This specification is the specification for a specification"
      TextCompressor.new(text: text)
    end

    include_examples "text compressor"
  end
end

module BestCompressor
  describe TextCompressor do
    let(:compressor) do
      text = "This specification is the specification for a specification"
      TextCompressor.new(text: text)
    end

    include_examples "text compressor"

    it "makes lets internal methods leak out" do
      pub_methods = TextCompressor.public_instance_methods
      expect(pub_methods.include?(:unique_index_of)).to be_truthy
      expect(pub_methods.include?(:add_unique_word)).to be_truthy
      expect(pub_methods.include?(:add_word)).to be_truthy
      expect(pub_methods.include?(:add_text)).to be_truthy
    end
  end
end

module PrivateCompressor
  describe TextCompressor do
    let(:compressor) do
      text = "This specification is the specification for a specification"
      TextCompressor.new(text: text)
    end

    include_examples "text compressor"

    it "makes internal methods private" do
      priv_methods = TextCompressor.private_instance_methods
      expect(priv_methods.include?(:unique_index_of)).to be_truthy
      expect(priv_methods.include?(:add_unique_word)).to be_truthy
      expect(priv_methods.include?(:add_word)).to be_truthy
      expect(priv_methods.include?(:add_text)).to be_truthy
    end

    it "raises an exception if a private method is called" do
      expect do
        compressor.add_word("foo")         # Boom!
      end.to raise_error(NoMethodError)
    end

    it "allows you to call private methods with send" do
      compressor.send(:add_text, "Hello")
      expect(
        compressor.send(:unique_index_of, "is")
      ).to eq(2)
    end
  end

  describe FileTextCompressor do
    before(:all) do
      File.open("file_compressor.txt", "w") { |f| f.puts "Out There" }
    end

    after(:all) do
      FileUtils.rm_f("file_compressor.txt")
    end

    let(:compressor) do
      text = "This specification is the specification for a specification"
      FileTextCompressor.new(text: text)
    end

    include_examples "text compressor"

    it "can read files" do
      c = FileTextCompressor.new(text: "Hello")
      c.add_text_from_file("file_compressor.txt")
      expect(c.unique.include?("Hello")).to be_truthy
      expect(c.unique.include?("Out")).to be_truthy
      expect(c.unique.include?("There")).to be_truthy
    end
  end
end

module TroubledCompressor
  describe TextCompressor do
    let(:compressor) do
      text = "This specification is the specification for a specification"
      TextCompressor.new(text: text)
    end

    include_examples "text compressor"
  end
end

