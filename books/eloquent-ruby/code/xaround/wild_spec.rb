#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "opening a file" do
  it "works the way it always has" do
    # No file here!

    File.open("secret.txt") do |f|
      # Able to read the file here. 
      txt = f.read
      expect(txt).to eq("Attack!\n")
    end

    # File is closed!
  end
end


