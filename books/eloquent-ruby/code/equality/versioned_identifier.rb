#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "document_identifier"

module WellBehaved
  class DocumentIdentifier < Final::DocumentIdentifier; end

  class VersionedIdentifier < DocumentIdentifier
    attr_reader :version

    def initialize(folder:, name:, version:)
      super(folder:, name:)
      @version = version
    end

    def ==(other)
      if other.instance_of? VersionedIdentifier
        other.folder == folder &&
          other.name == name &&
          other.version == version
      elsif other.instance_of? DocumentIdentifier
        other.folder == folder && other.name == name
      else
        false 
      end
    end
  end

  class VersionedIdentifier
    # Stuff omitted...

    def as_document_identifier
      DocumentIdentifier.new(folder: folder, name: name)
    end
  end

  class VersionedIdentifier
    # Stuff omitted...

    def is_same_document?(other)
      other.folder == folder && other.name == name
    end
  end
end
