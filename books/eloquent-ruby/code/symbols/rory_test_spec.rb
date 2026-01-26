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


describe "Rory Test" do
  it "helps determine what to use for hash keys" do
    str_hash =
      {"title" => "Brave New World"}

    expect(str_hash["title"]).to match(/Brave/)

    sym_hash =
      {title: "Brave New World"}

    expect(sym_hash[:title]).to match(/Brave/)

    rory_key_hash =
      {rory: "Brave New World"}

    expect(rory_key_hash[:rory]).to match(/Brave/)

    rory_value_hash =
      {title: "Brave New Rory"}
    expect(rory_value_hash[:title]).to match(/Brave.*Rory/)

    freq_hash = 
      {"of" => 3730, "the" => 4242, "her" => 2119}
    expect(freq_hash["the"]).to eq(4242)
  end
end
