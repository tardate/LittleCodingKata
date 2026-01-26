#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

# This class is broken in two different ways.

class Message < Document
  # Most of the class omitted...

  # Send this message to off via email
  def send(recipient)
    # Do some interesting SMTP stuff...
  end
end

class Message < Document
  # Most of the class omitted...
  
  def to_s
    "Message: [#{title}] from #{aothor}"  # From whom?
  end
end


