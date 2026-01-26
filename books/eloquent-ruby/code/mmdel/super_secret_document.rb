#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module Basic
  class SuperSecretDocument
    def initialize(original_document:, time_limit_in_seconds:)
      @original_document = original_document
      @time_limit_in_seconds = time_limit_in_seconds
      @create_time = Time.now
    end

    def time_expired?
      Time.now - @create_time >= @time_limit_in_seconds
    end

    def check_for_expiration
      raise "Document no longer available" if time_expired?
    end

    def content
      check_for_expiration
      @original_document.content
    end

    def title
      check_for_expiration
      @original_document.title
    end

    def author
      check_for_expiration
      @original_document.author
    end

    # and so on...
  end
end

module MoreReal
  class SuperSecretDocument
    def initialize(original_document:, time_limit_in_seconds:)
      @original_document = original_document
      @time_limit_in_seconds = time_limit_in_seconds
      @create_time = Time.now
    end

    def time_expired?
      Time.now - @create_time >= @time_limit_in_seconds
    end

    def check_for_expiration
      raise "Document no longer available" if time_expired?
    end

    # content, title, and author methods omitted
    # to keep from adding more scrolling...
 
    def content
      check_for_expiration
      @original_document.content
    end

    def title
      check_for_expiration
      @original_document.title
    end

    def author
      check_for_expiration
      @original_document.author
    end

    # And some new methods...

    def page_layout
      check_for_expiration
      @original_document.page_layout
    end

    def page_size
      check_for_expiration
      @original_document.page_size
    end

    # and so on...
  end
end

module MMImplementation
  class SuperSecretDocument
    def initialize(original_document:, time_limit_in_seconds:)
      @original_document = original_document
      @time_limit_in_seconds = time_limit_in_seconds
      @create_time = Time.now
    end
  
    def time_expired?
      Time.now - @create_time >= @time_limit_in_seconds
    end
  
    def check_for_expiration
      raise "Document no longer available" if time_expired?
    end
  
    def method_missing(name, *args)
      check_for_expiration
      @original_document.send(name, *args)
    end
  end
end

module MoreDiscriminating
  SuperSecretDocument = MMImplementation::SuperSecretDocument.clone

  class SuperSecretDocument
    DELEGATED_METHODS = %i[content words]
  
    def method_missing(name, *args)
      check_for_expiration
  
      return super unless DELEGATED_METHODS.include?(name)
  
      @original_document.send(name, *args)
    end
  end
end

module FromBasicObject
  class SuperSecretDocument < BasicObject
    # ...
  end
  
  class SuperSecretDocument
    def initialize(original_document:, time_limit_in_seconds:)
      @original_document = original_document
      @time_limit_in_seconds = time_limit_in_seconds
      @create_time = ::Time.now
    end
  
    def time_expired?
      ::Time.now - @create_time >= @time_limit_in_seconds
    end
  
    def check_for_expiration
      raise "Document no longer available" if time_expired?
    end
  
    def method_missing(name, *args)
      check_for_expiration
      @original_document.send(name, *args)
    end
  end
end
