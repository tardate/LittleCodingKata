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
  class MarketingMessage < Document
    def replace_word(old_word, new_word)
      @content.gsub!(old_word, new_word)
    end
  end
  
  class MarketingMessage < Document
    def replace_word(old_word, new_word)
      @content.gsub!(old_word, new_word)
    end

    def replace_title(new_title)    = replace_word("TITLE", new_title)
    def replace_firstname(new_name) = replace_word("FIRSTNAME", new_name)
    def replace_lastname(new_name)  = replace_word("LASTNAME", new_name)
  end
end

module WithMM
  class MarketingMessage < Document
    def replace_word(old_word, new_word)
      @content.gsub!(old_word, new_word)
    end
  end

  class MarketingMessage < Document
    # Rest of the class omitted

    def method_missing(name, *args)
      string_name = name.to_s
      return super unless string_name.match?(/replace_.+/)

      old_word = extract_old_word(string_name)
      replace_word(old_word, args.first)
    end

    def extract_old_word(name) = name.split("_")[1].upcase
  end

  class MarketingMessage < Document
    def respond_to_missing?(name, _include_private)
      string_name = name.to_s
      return true if string_name.match?(/^replace_.+/)
      super
    end
  end
end
