#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# This is a stand in for the real printer class, the one that would
# talk to a physical printer.
class Printer
  # Return true if the physical printer is up and running.
  def available?
    raise "Should not be called!"
  end

  # Render the text on the printed page.
  def render(text)
    raise "Should not be called!"
  end
end


class PretendPrinter
  def available?
    true
  end

  def render(text)
    :complete
  end
end
