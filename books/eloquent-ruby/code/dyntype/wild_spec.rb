#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe File do
  it "lets you open a file" do
    open_file = File.open('hello.txt')
    expect(open_file.read).to match(/Hello/)
  end
end

describe :StringIO do
  it "quacks like a File instance" do
    require "stringio"

    open_string = StringIO.new("So say we all!\nSo say we all!\n")
    expect(open_string.read).to match(/So say/)
  end
end
