#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "document_with_to_s"

module ToS
  describe "importance of oo" do
    it "has a default to_s" do
      expect do
        doc = Document.new(
          title: "Emma",
          author: "Austen",
          content: "Emma Woodhouse, ..."
        )

        puts doc
      end.to output(/Document: Emma by Austen/).to_stdout
    end

    it "gives you access to instance variable names" do
      doc = Document.new(title: "t", author: "a", content: "c")

      result =
        [:@title, :@author, :@content]
      expect(
        doc.instance_variables
      ).to eq(result)
    end
  end
end
