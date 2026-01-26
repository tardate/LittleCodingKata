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

require "rubygems"
# TBD Ruby gems loaded_gems example
#

EXPECTED =
  {
    "super-hero" => [
      {"name" => "Spiderman", "origin" => "Radioactive Spider"},
      {"name" => "Hulk", "origin" => "Gamma Rays"},
    ]
  }


describe "json gem" do
  it "lets you read json into data structures" do
    require "json"
    data = JSON.load_file("characters.json")
    expect(data).to eq(EXPECTED)
  end
end
