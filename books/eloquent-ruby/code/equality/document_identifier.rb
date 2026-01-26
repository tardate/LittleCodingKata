#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module Simple
  class DocumentIdentifier
    attr_reader :folder, :name
  
    def initialize(folder:, name:)
      @folder = folder
      @name = name
    end
  end
end


module DoubleEquals
  class DocumentIdentifier
    attr_reader :folder, :name
  
    def initialize(folder:, name:)
      @folder = folder
      @name = name
    end
  
    def ==(other)
      return false unless other.is_a?(self.class)
      folder == other.folder && name == other.name
    end
  end
end

module Quick
  class DocumentIdentifier
    attr_reader :folder, :name
  
    def initialize(folder:, name:)
      @folder = folder
      @name = name
    end

     def ==(other)
      return true if other.equal?(self)
      return false unless other.instance_of?(self.class)
      folder == other.folder && name == other.name
    end
  end
end

module KindOf
  class DocumentIdentifier
    attr_reader :folder, :name
  
    def initialize(folder:, name:)
      @folder = folder
      @name = name
    end

    def ==(other)
      return true if other.equal?(self)
      return false unless other.kind_of?(self.class) 
      folder == other.folder && name == other.name
    end
  end
  
  class ContractIdentifier < DocumentIdentifier
  end
end

module Final
  class DocumentIdentifier
    #...

    attr_reader :folder, :name
  
    def initialize(folder:, name:)
      @folder = folder
      @name = name
    end
    def ==(other)
      return false unless other.respond_to?(:folder)
      return false unless other.respond_to?(:name)
      folder == other.folder && name == other.name
    end 
  end
end

module WithHashEql
  class DocumentIdentifier < Final::DocumentIdentifier; end

  class DocumentIdentifier
  
    # Code omitted...
    def hash
      folder.hash ^ name.hash
    end
  
    def eql?(other)
      return false unless other.instance_of?(self.class)
      folder == other.folder && name == other.name
    end 
  end
end
