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

def print_size(o)
  puts "The size is #{o.size}"
end

class Document
  # ...
  
  def size
    words.size
  end
end

describe "duck typing" do
  it "lets us call the size method on anything any object" do
    doc = Document.new( title: "test", author: "russ", content: "Hello world!" )

    expect do
      print_size(doc)
    end.to output(/The size.*2/).to_stdout

    expect do
      print_size("To be or not to be")
    end.to output(/The size.*18/).to_stdout

    expect do
      print_size([1, 2, 3])
      print_size({fname: "Leo", lname: "Tolstoy"})
    end.to output(/The size.*3.*size.*2/m).to_stdout

    expect do
      # How long is the file?
      print_size(open("hello.txt"))

      # How many bytes does this integer take up?
      print_size(1234)
    end.to output(/The size.*23.*size.*8/m).to_stdout
  end
end
