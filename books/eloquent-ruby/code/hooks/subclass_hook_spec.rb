#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "../common/document"

class SimpleBaseClass
  def self.inherited(new_subclass)
    puts "Hey #{new_subclass} is now a subclass of #{self}!"
  end
end

describe "inherited hook" do
  it "fires when you subclass a class" do
    # This needs to match the output in the text!
    msg = "Hey ChildClassOne is now a subclass of SimpleBaseClass!\n"

    expect do
    class ChildClassOne < SimpleBaseClass
    end
    
    end.to output(msg).to_stdout
  end
end
