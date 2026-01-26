#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "author"
require_relative "title"
require_relative "unrelated_docs"


describe Title do
  it "Hangs onto the data we give it" do
    title = Title.new(main_title: "War & Peace", subtitle: "Guns & Roses")
    expect(title.main_title).to eq("War & Peace")
    expect(title.subtitle).to eq("Guns & Roses")
  end
end

describe Author do
  it "Hangs onto the data we give it" do
    author = Author.new(first_name: "Leo", last_name: "Tolstoy")
    expect(author.first_name).to eq("Leo")
    expect(author.last_name).to eq("Tolstoy")
  end
end

module UnrelatedDocs
  describe Document do
    it "Hangs onto the data we give it" do
      author = Author.new(first_name: "Leo", last_name: "Tolstoy")
      title = Title.new(main_title: "War & Peace", subtitle: "Guns & Roses")
      doc = Document.new(author:, title:, content: "Well, Prince, so Genoa...")
      expect(doc.title.main_title).to eq("War & Peace")
      expect(doc.author.first_name).to eq("Leo")
    end
  end
end

