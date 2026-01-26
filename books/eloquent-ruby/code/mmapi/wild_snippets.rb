#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# See: https://github.com/sparklemotion/nokogiri/blob/7fe3268bd6ccfedf475ce04792bd0cc02bfbcc0d/lib/nokogiri/xml/builder.rb#L382C3-L390C10

def method_missing(method, *args, &block) # :nodoc:
  if @context&.respond_to?(method)
    @context.send(method, *args, &block)
  else
    node = @doc.create_element(method.to_s.sub(/[_!]$/, ""), *args)
    bind_ns(node)
    insert(node, &block)
  end
end
