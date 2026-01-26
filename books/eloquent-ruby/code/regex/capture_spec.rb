#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"


describe "capturing regex matches" do
  it "helps you grab the specific text your regex matches" do
    matched = false
    time_regex = /\d\d:\d\d (AM|PM)/
    the_string = "At the tone the time will be 08:17 PM. Thank you."

    if time_regex.match?(the_string)
      # Good news: We know our string contains a time.
      # Bad news: We don"t what time.
      matched = true
    end
    expect(matched).to be_truthy
  end

  it "uses the match method" do
    time_regex = /\d\d:\d\d (AM|PM)/
    the_string = "At the tone the time will be 08:17 PM. Thank you."

    # Note we are using match, not match? here.

    m = time_regex.match(the_string)

    m.string       # "At the tone..."
    m.regexp       # The regular expression /\d\d:\d\d (AM|PM)/

    expect(m.string).to eq(the_string)
    expect(m.regexp).to eq(time_regex)

    m[0]           # "08:17 PM"

    expect(m[0]).to eq("08:17 PM")
  end

  it "lets you extract a portion of the match" do
    expect do
      # Note the parentheses around the AM and PM alternative. 
      time_regex = /\d\d:\d\d (AM|PM)/

      first_match = time_regex.match("08:59 AM")
      puts first_match[1]     # Prints AM.

      second_match = time_regex.match("04:20 PM")
      puts second_match[1]    # Prints PM.
    end.to output(/^AM.*PM$/m).to_stdout
  end

  it "lets you extract a portion of the match" do
    expect do
      # Note the parentheses around the hours, minutes and AM and PM alternative. 
      hrs_mins_regex = /(\d\d):(\d\d) (AM|PM)/

      m = hrs_mins_regex.match("04:20 PM")

      # Print the capture groups.

      puts m[1]              # Prints 04.
      puts m[2]              # Prints 20.
      puts m[3]              # Prints PM. 

      # And we still have the whole match in the first element.

      puts m[0]              # Prints 04:20 PM.
    end.to output(/^04.*20.*PM/m).to_stdout
  end
end
  
