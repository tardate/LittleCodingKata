#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "author"
require_relative "title"
require_relative "doc_with_description"

module DocWithDescription
  describe Document do
    it "works fine with Title and Author" do
      author = Author.new(first_name: "Russ", last_name: "Olsen")
      title = Title.new(main_title: "Overdrive", subtitle: "OD")
      doc = Document.new(title:, author:, content: "The cops...")

      expect(doc.description).to match(/Document.*Over.*Olsen/)
    end

    it "breaks horribly with strings" do
      expect  do
        # Oh nooooo!
        doc = Document.new(
          title: "Emma", 
          author: "Jane Austen",
          content: "Emma Woodhouse, handsome..."
        )
        puts doc.description
      end.to raise_error(NoMethodError)
    end
  end
end
