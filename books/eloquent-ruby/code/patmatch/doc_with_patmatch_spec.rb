#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_with_patmatch"

def print_book_info(doc)
  case doc
  in { title: "Emma", author: "Austen" }
    puts "It's the novel Emma by Jane Austen!"
  in { author: "Austen" }
    puts "It's another Austen book!"
  in { title: "Emma" }
    puts "It's Emma by a different author"
  else
    puts "No idea!"
  end
end

def match_book_content(doc)
  case doc
  in ["It", "was", "the", "best", "of", "times", *]
    puts "It's Dickens!"
  in ["It", "was", "a", "dark", "and", *]
    puts "It's Paul Clifford!"
  in [*, "to", "be", "or", "not", *]
    puts "It's Hamlet!"
  else
    puts "No idea!"
  end
end

module WithPatMatch
  describe Document do
    let(:doc) do
      doc = Document.new(
        title: "Emma",
        author: "Austen",
        content: "Emma Woodhouse, handsome...")
      doc
    end

    it "returns its data as a hash with deconstruct_keys" do
      data =
      {title: "Emma", author: "Austen", content: "Emma Woodhouse, handsome..."}
      expect(doc.deconstruct_keys(nil)).to eq(data)
    end

    it "matches the first case" do
      expect do
        print_book_info(doc)
      end.to output(/the novel Emma by Jane/).to_stdout
    end

    it "matches the second case" do
      doc.title = "Persuasion"
      expect do
        print_book_info(doc)
      end.to output(/another Austen/).to_stdout
    end

    it "matches the third case" do
      doc.author = "Edward Bulwer-Lytton"
      expect do
        print_book_info(doc)
      end.to output(/different author/).to_stdout
    end

    it "matches the else case" do
      doc.author = "Edward Bulwer-Lytton"
      doc.title = "Paul Clifford"
      expect do
        print_book_info(doc)
      end.to output(/No idea/).to_stdout
    end

    it "matches words in the document against an array" do
      doc.content = "to be or not to be, that is the question"
      expect { match_book_content(doc) }.to output(/Hamlet/).to_stdout
      
      doc.content = "It was a dark and stormy night, suddenly..."
      expect { match_book_content(doc) }.to output(/Paul C/).to_stdout

      doc.content = "It was the best of times it was the worst of times"
      expect { match_book_content(doc) }.to output(/Dickens/).to_stdout
    end
  end
end

