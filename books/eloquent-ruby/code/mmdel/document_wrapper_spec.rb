#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "document_wrapper"

describe Document do
  let(:wrapper_doc) do
    text = "The Hare was once boasting of his speed..."
    real_doc = Document.new(
      title: "Hare & Tortise",
      author: "Aesop",
      content: text
    )
    wrapper_doc = DocumentWrapper.new(real_doc)
  end

  it "picks up the fields in the constructor" do
    expect do
      puts wrapper_doc.title
      puts wrapper_doc.author
      puts wrapper_doc.content
    end.to output(/Hare & Tor.*Aesop.*The Hare/m).to_stdout
  end
end
