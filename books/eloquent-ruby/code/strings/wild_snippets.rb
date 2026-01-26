#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
=begin
# See https://github.com/ruby/ruby/blob/b68172caada45724a302f337334f29ebae5a0e1e/lib/syntax_suggest/lex_value.rb#L35

case token
    when "if", "unless", "while", "until"
    @is_kw = true unless expr_label?
    when "def", "case", "for", "begin", "class", "module", "do"
    @is_kw = true
    when "end"
    @is_end = true
    end
end

# See https://github.com/rails/rails/blob/b97917da8a801bf5360c3a9da913415bc8582735/activesupport/lib/active_support/inflections.rb#L68

  inflect.irregular("person", "people")

  
  # Some rules omitted...

  inflect.irregular("move", "moves")
  inflect.irregular("zombie", "zombies")


# See https://github.com/rails/rails/blob/b97917da8a801bf5360c3a9da913415bc8582735/activesupport/lib/active_support/inflector/methods.rb#L382
  
   rules.each { |(rule, replacement)| break if result.sub!(rule, replacement) }
=end

