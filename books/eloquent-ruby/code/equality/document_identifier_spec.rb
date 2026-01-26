#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "document_identifier"
#require_relative "../common/utils"

module Simple
  describe Simple::DocumentIdentifier do
    let(:x) { DocumentIdentifier.new(folder: "plans", name: "raygun.txt")  }
    let(:y) { DocumentIdentifier.new(folder: "plans", name: "raygun.txt") }

    it "respects equals?, like every Ruby object" do
      expect(
        x.equal?(y)
      ).to be_falsey

      expect(x.equal?(x)).to be_truthy
      expect(y.equal?(y)).to be_truthy
    end

    it "breaks with ==" do
      expect do
        first_id = DocumentIdentifier.new(folder: "plans", name: "raygun.txt") 
        second_id = DocumentIdentifier.new(folder: "plans", name: "raygun.txt")

        puts "They are equal!" if first_id == second_id
      end.to output("").to_stdout
    end
  end
end

module DoubleEquals
  describe DocumentIdentifier do
    it "has a working ==" do
      first_id = DocumentIdentifier.new(folder: "plans", name: "raygun.txt") 
      second_id = DocumentIdentifier.new(folder: "plans", name: "raygun.txt")

      diff_id = DocumentIdentifier.new(folder: "rummors", name: "ufo.txt")

      expect do
        puts "They are equal!" if first_id == second_id
      end.to output(/They are equal/).to_stdout

      expect(first_id == first_id).to be_truthy
      expect(first_id == diff_id).to be_falsey
    end
  end
end

module Quick
  describe DocumentIdentifier do
    it "has a working ==" do
      expect do
        first_id = DocumentIdentifier.new(folder: "plans", name: "raygun.txt") 
        second_id = DocumentIdentifier.new(folder: "plans", name: "raygun.txt")

        puts "They are equal!" if first_id == second_id
      end.to output(/They are equal/).to_stdout
    end
  end
end

module KindOf
  describe DocumentIdentifier do
    it "has a working doc_id == con_id" do
      expect do
      doc_id = DocumentIdentifier.new(folder: "contracts", name: "big_deal.txt") 
      con_id = ContractIdentifier.new(folder: "contracts", name: "big_deal.txt")

      puts "They are equal!" if doc_id == con_id
      end.to output(/equal!/).to_stdout
    end

    it "has a broken con_id == doc_id" do
      expect do
        doc_id = DocumentIdentifier.new(folder: "contracts", name: "big_deal.txt") 
        con_id = ContractIdentifier.new(folder: "contracts", name: "big_deal.txt")
  
        # Note that we have switched the order!
        puts "They are equal!" if con_id == doc_id
        end.to output("").to_stdout
      end
  end
end

module Final
  describe DocumentIdentifier do
    it "has strange behavior as a hash key" do
      hash = {}

      document = Document.new(
        author: "cia", 
        title: "Roswell", 
        content: "Weather balloon!")

      first_id = DocumentIdentifier.new(folder: "public", name: "CoverStory")
      hash[first_id] = document

      second_id =  DocumentIdentifier.new(folder: "public", name: "CoverStory")
      the_doc_again =  hash[second_id]

      expect(the_doc_again).to be_nil
    end
  end
end

module WithHashEql
  describe DocumentIdentifier do
    it "has works as a hash key" do
      hash = {}
      document = Document.new( author: "cia", title: "Roswell", content: "Weather balloon!")

      first_id = DocumentIdentifier.new(folder: "public", name: "CoverStory")
      hash[first_id] = document
      second_id =  DocumentIdentifier.new(folder: "public", name: "CoverStory")
      the_doc_again =  hash[second_id]
      expect(the_doc_again).to be(document)
    end
  end
end
