#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

  class RepeatBackToMe
    def method_missing(method_name, *args)
      puts "Hey, you just called the #{method_name} method."
      puts "With these arguments: #{args.join(" ")}."
      puts "But there ain't no such method."
    end
  end
