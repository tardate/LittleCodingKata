#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "ins_def_meth"

module WithDefineMethod
  describe Instructions do
    it "generate methods with the correct self" do
      omelette_how_to = Instructions.new(title: "Omelettes", author: "Russ") do |ins|
        ins.step "First you need to break some eggs..."
      end
      expect(omelette_how_to.content).to match(/First you/)
    end
  end
end

