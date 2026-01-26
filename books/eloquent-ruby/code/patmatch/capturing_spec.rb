#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "Capturing values from regexp" do
  it "just needs some parens" do
    expect do
      the_string = "09:24 AM"

      match = /(\d\d):\d\d (AM|PM)/.match(the_string)

      puts match[1]     # The hours, "09".
    end.to output("09\n").to_stdout
  end
end

describe "Capturing values in patterns" do
  let(:info) do
    ["Emma", "Austen", :drama, 1816]
  end

  it "right assignment goes the other way" do
    # The same as the more familiar the_number = 42.

    42 => the_number

    expect(the_number).to eq(42)
  end

  it "lets you pluck values from arrays with a =>" do
    expect do
      # Pluck title out if info matches.

      if info in [String => title, String, :drama | :comedy | :tragedy, Integer]
        puts "The title is #{title}"
      end
    end.to output(/title is.*Emma/).to_stdout
  end

  it "lets you skip the => sometimes" do
    expect do
      # Here we just assume that title and author are what we want if 
      # the array ends with a valid symbol and an integer.

      if info in [title, author, :drama | :comedy | :tragedy, Integer]
        puts "The title is #{title} and the author is #{author}"
      end
    end.to output(/title is Emma.*Austen/).to_stdout
  end

  it "lets you skip all of the => if you have faith" do
    expect do
      # If info is a four element array, assume it is
      # a book array and pull the data out.

      if info in [title, author, genre, year]
        puts "The title is #{title} and the author is #{author}"
        puts "The genre is #{genre} and it was published in #{year}"
      end
    end.to output(/title is Emma.*Austen.*drama.*1816/m).to_stdout
  end

  it "lets you use in w/o an if" do
    info in [title, author, genre, year]
    expect(title).to eq("Emma")
    expect(author).to eq("Austen")
    expect(genre).to eq(:drama)
    expect(year).to eq(1816)
  end

  it "works better with a =>" do
    # Extract the elements of the array if info is a four element array.
    # Raises an exception if info is not a four element array.

    info => [title, author, genre, year]

    expect(title).to eq("Emma")
    expect(author).to eq("Austen")
    expect(genre).to eq(:drama)
    expect(year).to eq(1816)

    expect do
      42 => [title, author, genre, year]
    end.to raise_error(NoMatchingPatternError)
  end
 
  it "lets you grab any other elements with *name" do
    # Grab the title and the rest of the elements from info.

    info => [title, *trailing_elements]

    expect(title).to eq("Emma")
    expect(trailing_elements).to eq(["Austen", :drama, 1816])

    info => [*leading_elements, Integer]
    expect(leading_elements).to eq(["Emma", "Austen", :drama])
  end
end
