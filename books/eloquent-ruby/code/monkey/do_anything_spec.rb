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

module DoAnything
  describe "Messing with the method visibility in a class" do
    Document = ::Document.clone


    it "is the wild west!" do
      expect(Document.public_instance_methods).to include(:word_count)
      expect(Document.public_instance_methods).to include(:words)

      class Document
        private :word_count
      end

      expect(Document.private_instance_methods).to include(:word_count)
      expect(Document.public_instance_methods).to include(:words)

      class Document
        public :word_count
      end

      expect(Document.public_instance_methods).to include(:word_count)
      expect(Document.public_instance_methods).to include(:words)

      class Document
        remove_method :word_count
      end
      #
      expect(Document.instance_methods.include?(:word_count)).to be_falsey
      expect(Document.instance_methods.include?(:words)).to be_truthy
    end
  end
end
