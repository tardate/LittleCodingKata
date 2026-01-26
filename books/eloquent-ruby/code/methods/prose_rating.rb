#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module Decent
  class Document < ::Document; end

  class Document
    # Most of class omitted...

    def prose_rating
      if pretentious_density > 0.3
        if informal_density < 0.2
          return :really_pretentious
        else
          return :somewhat_pretentious
        end
      elsif pretentious_density < 0.1
        if informal_density > 0.3
          return :really_informal
        end
        return :somewhat_informal
      else
        return :about_right
      end
    end

    def pretentious_density
      # Somehow compute density of pretentious words
    end

    def informal_density
      # Somehow compute density of informal words
    end
  end
end

module Better
  class Document < ::Document; end

  class Document
    # Most of class omitted...

    def prose_rating
      rating = :about_right

      if pretentious_density > 0.3
        if informal_density < 0.2
          rating = :really_pretentious
        else
          rating = :somewhat_pretentious
        end
      elsif pretentious_density < 0.1
        if informal_density > 0.3
          rating = :really_informal
        else
          rating = :somewhat_informal
        end
      end
      rating
    end
  end
end

module Best
  class Document < ::Document; end

  class Document
    # Most of class omitted...

    def prose_rating
      return :really_pretentious if really_pretentious?
      return :somewhat_pretentious if somewhat_pretentious?
      return :really_informal if really_informal?
      return :somewhat_informal if somewhat_informal?
      return :about_right
    end

    def really_pretentious?
      pretentious_density > 0.3 && informal_density < 0.2
    end

    def somewhat_pretentious?
      pretentious_density > 0.3 && informal_density >= 0.2
    end

    def really_informal?
      pretentious_density < 0.1 && informal_density > 0.3
    end

    def somewhat_informal?
      pretentious_density < 0.1 &&  informal_density <= 0.3
    end

    # pretentious_density and informal_density methods omitted.
  end
end
