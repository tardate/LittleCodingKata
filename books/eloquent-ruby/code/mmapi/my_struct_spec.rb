#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "my_struct"

describe MyStruct do
  it "lets you make up fields on the fly" do
    expect do
      author = MyStruct.new(first_name:"Stephen")
      author.last_name = "Hawking"

      puts author.first_name
      puts author.last_name
    end.to output(/Stephen\nHawking/m).to_stdout
  end
end
