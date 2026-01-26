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

class Document
  attr_accessor :title, :author, :content

  def initialize(title:, author:, content: "")
    @title = title
    @author = author
    @content = content

    yield self if block_given?
  end
end

describe "Document with execute around initialize" do
  it "lets you do extra stuff in the initialize method" do
    new_doc = Document.new(title: "US Constitution", author: "Madison") do |doc|
      doc.content << "We the people"
      doc.content << "In order to form a more perfect union"
      doc.content << "provide for the common defense"
    end
    expect(new_doc.content).to match(/We the .*order.*defense/)
  end
end
