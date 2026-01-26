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
require_relative "doc_index"

describe "iterating thru arrays" do
  it "is possible to use for" do
     expect do
      words = %w{Mary had a little lamb}

      for i in 0...words.size
        puts words[i]
      end
    end.to output(/^Mary\nhad\na/m).to_stdout

    expect do
      words = %w{Mary had a little lamb}

      words.each { |word| puts word }
    end.to output(/^Mary\nhad\na/m).to_stdout
  end
end

describe "iterating thru hashes" do
  it "is possible for iterate via each entry" do
    expect do
      movie = { title: "2001", genre: "sci fi", rating: 10 }
      movie.each { |entry| pp entry }
    end.to output(/\[:title.*2001.*genre.*10\]/m).to_stdout

    [:title, "2001"]
    [:genre, "sci fi"]
    [:rating, 10]
  end

  it "is possible to pick up the names and values" do
    movie = { title: "2001", genre: "sci fi", rating: 10 }
    expect do
      movie.each { |name, value| puts "#{name} => #{value}"}
    end.to output(/title => 2001.*rating => 10/m).to_stdout
  end
end

describe "finding an index by hand" do
  it "at least works" do
    doc = ForIndex::Document.new(title: "t", author: "a", content: "aa bb cc")

    expect(doc.word_index("aa")).to eq(0)
    expect(doc.word_index("cc")).to eq(2)
    expect(doc.word_index("xx")).to be_nil
  end
end

describe "finding an index with find_index" do
  it "at least works" do
    doc = FindIndex::Document.new(title: "t", author: "a", content: "aa bb cc")

    expect(doc.word_index("aa")).to eq(0)
    expect(doc.word_index("cc")).to eq(2)
    expect(doc.word_index("xx")).to be_nil
  end
end

describe "map" do
  it "is possible to map strings to their length" do
    doc = Document.new(author: "", title: "t", content: "The rain in Spain")
    pp doc.words.map { |word| word.size }

    [3, 5, 2, 3, 4]
  end

  it "is possible to map strings to their lowercase versions" do
    doc = Document.new(author: "", title: "t", content: "AAA Abc def")
    lower_case_words = doc.words.map { |word| word.downcase }
    expect(lower_case_words).to eq(%w[aaa abc def])

    lower_case_words = doc.words.map(&:downcase)
    expect(lower_case_words).to eq(%w[aaa abc def])
  end
end

