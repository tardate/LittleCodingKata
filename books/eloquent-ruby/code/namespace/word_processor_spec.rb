#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "word_processor"


describe WordProcessor do
  it "has a Rendering module" do
    expect(WordProcessor::Rendering.class).to eq(Module)
    expect(WordProcessor::Rendering::Font.class).to eq(Class)
  end
end
