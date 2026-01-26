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
require_relative "doc_wrapper"

describe DocumentWrapper do
  it "delegates title, author and content to real doc" do
    expect do
      real_doc = Document.new(
        title: "Two Cities", 
        author: "Dickens", 
        content: "It was..."
      )

      wrapped_doc = DocumentWrapper.new(real_doc)

      puts wrapped_doc.title
      puts wrapped_doc.author
      puts wrapped_doc.content
    end.to output(/Two.*Dickens.*It was/m).to_stdout
  end

  it "has actual delegating methods" do
    expect(DocumentWrapper.instance_methods).to include(:title)
    expect(DocumentWrapper.instance_methods).to include(:author)
    expect(DocumentWrapper.instance_methods).to include(:content)
  end
end
