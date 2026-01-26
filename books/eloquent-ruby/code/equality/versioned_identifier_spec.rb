#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "document_identifier"
require_relative "versioned_identifier"

module WellBehaved
  class DocumentIdentifier < Final::DocumentIdentifier; end

  describe VersionedIdentifier do
    it "has a partially well-behaved ==" do
      versioned1 = VersionedIdentifier.new(folder: "specs", name: "bfg9k", version: "V1")
      versioned2 = VersionedIdentifier.new(folder: "specs", name: "bfg9k", version: "V2")
      unversioned = DocumentIdentifier .new(folder:"specs", name: "bfg9k")
     
      expect(
        versioned1 == unversioned     # True!
      ).to be_truthy

      expect(
        unversioned == versioned2     # True!
      ).to be_truthy

      expect(
      versioned1 == versioned2        # Not true!
      ).to be_falsey
    end
  end
end
