#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module WithDefineMethod
  class MarketingMessage < Document
    def replace_word(old_word, new_word)
      @content.gsub!(old_word, new_word)
    end

    def self.add_replace_method(name)
      placeholder = name.to_s.upcase
      method_name = "replace_#{name}".to_sym
      define_method(method_name) do |replacement|
        @content.gsub!(placeholder, replacement)
      end
    end

    add_replace_method(:title)
    add_replace_method(:firstname)
    add_replace_method(:lastname)
  end
end
