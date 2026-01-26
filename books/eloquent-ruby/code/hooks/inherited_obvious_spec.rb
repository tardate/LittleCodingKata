#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module InheritedObviousOrder
  describe "inherited" do
    it "is called in the order you expect" do
      expect do
        class DocumentReader
          # Stuff omitted
          def self.inherited(clazz)
            puts "Inherited #{clazz}"
          end
        end

        class PlainTextReader < DocumentReader
          # Stuff omitted
        end

        # Inherited method for PlainTextReader goes off about now.

        class YAMLReader < DocumentReader
          # Stuff omitted
        end

        # Inherited method for YAMLReader goes off about now.


        class JSONReader < DocumentReader
          # Stuff omitted
        end

        # Inherited method for JSONReader goes off about now.

      end.to output(/PlainText.*YAML.*JSON/m).to_stdout
    end
  end
end
