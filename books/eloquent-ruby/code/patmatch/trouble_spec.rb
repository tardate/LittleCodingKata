#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "pattern matching snares" do
  let(:h_info) do
    { title: "Emma", author: "Austen", genre: :drama, published: 1816 }
  end

  it "lets you make an exact match on hashes, with odd syntax" do
    expect((
      # Match only hashes that have :title, :author, :genre and :published
      # keys and no others. Note the **nil.

      h_info in { title: _, author: _, genre: _, published: _, **nil }
    )).to be_truthy

    h2 = h_info.clone
    h2[:extra] = 44
    expect((h2 in { title: _, author: _, genre: _, published: _, **nil })).to be_falsey
  end

  it "makes an empty pattern a bit inconsistent" do
    expect((
      # An easy going hash pattern.

      h_info in { title: _, author: _ }
    )).to be_truthy

    expect((
      # An even more easy-going pattern, matches any hash with :title.

      h_info in { title: _ }
    )).to be_truthy

    expect((
      # But then there is a rip in the space-time continuum.

      h_info in {}
    )).to be_falsey
  end

  it "has an empty hash pattern only match an empty hash" do
    h_info = {}
    expect do
      case h_info
      in {}
        puts "The hash is empty!"
      else
        puts "The hash is not empty!"
      end
    end.to output(/is empty/).to_stdout
  end

  it "sets unmatched/undefined binding variables to nil" do
    # Initialize one of our variables.
    title = "Unknown"

    # This is not going to match. So what happens to
    # title and author?
    42 in [title, author, Symbol, Integer]

    expect(title).to eq("Unknown")
    expect(author).to be_nil
  end

  it "works the same way as undefined variables in guard clauses" do
    x = 99 if false
    expect(x).to be_nil
  end
end
