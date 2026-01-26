#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "a Ruby string" do
  it "supports chomp" do
    expect(
      "It was a dark and stormy night\n".chomp
    ).to match(/night$/)
  end

  it "supports sub and gsub" do
    result =
      "It is warm outside".sub("warm", "cold")
  
    expect(result).to match(/is cold/)
    
    expected = File.read("#{__dir__}/gsub.txt")
    expect{  
      puts "yes yes".sub("yes", "no")
      puts "yes yes".gsub("yes", "no")
    }.to output(expected).to_stdout
  end

  it "supports split" do
    result=
      "It was a dark and stormy night".split
    expected= 
      ["It", "was", "a", "dark", "and", "stormy", "night"]
    expect(result).to eq(expected)

    result = 
    "Bill:Shakespeare:Playwright:Globe".split(":")

    expected =
      ["Bill", "Shakespeare", "Playwright", "Globe"]
    expect(result).to eq(expected)
  end

  it "supports sub!" do
    title = "It was a dark and stormy night"
    title.sub!("dark", "bright")
    title.sub!("stormy", "clear")
    expect(title).to match(/It was a bright and clear/)
  end

  it "supports sub!" do
    result = 
    "It was a dark and stormy night".index("dark")
    # => 9
    expect(result).to eq(9)
  end
end
