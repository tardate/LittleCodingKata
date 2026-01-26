#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "hash pattern matching" do
  let(:h_info) do
    # Our book info cast as a hash.
    
    h_info  = { title: "Emma", author: "Austen", genre: :drama, published: 1816 }

    h_info
  end

  it "does back pattern matching" do
    expect((
    # A very specific pattern.

    h_info in { title: String, author: String, genre: Symbol, published: Integer }
    
    )).to be_truthy

    expect((
    # A much less picky pattern that still matches.
    # This one has a surprise in store, so keep reading!

    h_info in { title:, author:, genre:, published: }
    )).to be_truthy
  end

  it "matches even if there are additional keys in the hash" do
    expect((
      # True!

      h_info in { title: String, author: String }
    )).to be_truthy
  end

  it "binds variables with =>" do
    expect do
      # Set the_title and the_author and evaluate to true if info
      # is a hash with the right keys. Otherwise just return false.

      if h_info in { title: String => the_title, author: String => the_author }
        puts "The title is #{the_title}"
        puts "The author is #{the_author}"
      end
    end.to output(/title.*Emma.*Austen/m).to_stdout
  end

  it "lets you skip the => sometimes" do
    expect do
      if h_info in { title: the_title, author: the_author }
        puts "The title is #{the_title}"
        puts "The author is #{the_author}"
      end
    end.to output(/title.*Emma.*Austen/m).to_stdout
  end

  it "binds the keys by default" do
    # If the pattern matches, bind four local variables.

    h_info in { title:, author:, genre:, published: }

    puts title
    expect(title).to eq("Emma")
    expect(author).to eq("Austen")
    expect(genre).to eq(:drama)
    expect(published).to eq(1816)

    expect do
      if h_info in { title:, author:, genre:, published: }
        puts "#{title} is by #{author} and was published in #{published}."
        puts "You can find it in the #{genre} section."
      end
    end.to output(/Emma is.*drama/m).to_stdout
  end

  it "lets you skip the binding with _" do
    expect do
      # Match, but don't bind the variables.

      if h_info in { title: _, author: _, genre: _, published: _ }
        puts "We have some book info!"
      end
    end.to output(/We have/).to_stdout

    h_info in { title: _, author: _, genre: _, published: _ }
    expect(defined?(title)).to be_nil
  end

  it "has a * of its own" do
    h_info => { title:, **more_info }

    no_title = h_info.clone
    no_title.delete(:title)

    expect(more_info).to eq(no_title)
  end
end
