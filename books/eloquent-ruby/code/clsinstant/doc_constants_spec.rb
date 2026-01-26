#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

module UseConstants
  # We end up with three diffent values: Document::DEFAULT_FONT, 
  # Resume::DEFAULT_FONT and Presentation::DEFAULT_FONT.
  class Document
    DEFAULT_FONT = :times
    # ...
  end

  class Resume < Document
    DEFAULT_FONT = :arial
    # ...
  end

  class Presentation < Document
    DEFAULT_FONT = :nimbus
    # ...
  end

  describe "use of constants" do
    it "makes the class level values independent" do
      expect(Document::DEFAULT_FONT).to eq(:times)
      expect(Resume::DEFAULT_FONT).to eq(:arial)
      expect(Presentation::DEFAULT_FONT).to eq(:nimbus)
    end
  end
end
