#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

module ModuleMethod
  module WordProcessor
    def self.points_to_inches(points) = points / 72.0
    # etc... 
  end
end

module InstanceMethod
  module WordProcessor
    def points_to_inches(points) = points / 72.0
    # etc... 
  end
end

# Note that for isolation purposes we have an extra module
# here, for example OneLevel and TwoLevel.

module OneLevel
  module Rendering
    class Font
      #...
    end
  end
end

module TwoLevel
  module Rendering
    module GlyphSet
      class Font
        #...
      end
    end
  end
end

module TooManyLevels
  module Subsystem
    module Output
      module Rendering
        module GlyphSet
          class Font
            #...
          end
        end
      end
    end
  end
end

describe "module level methods" do
  it "lets you use the method directly" do
    expect(ModuleMethod::WordProcessor.points_to_inches(72)).to be_within(0.001).of(1.0)
  end

  it "defines an instance method on the module" do
    expect(ModuleMethod::WordProcessor.public_methods).to include(:points_to_inches)
  end
end

module OneLevel
  describe Rendering do
    it "does one level nesting" do
      expect(OneLevel::Rendering::Font).to be_instance_of(Class)
    end
  end
end

module TwoLevel
  describe Rendering do
    it "does two level nesting" do
      expect(TwoLevel::Rendering::GlyphSet::Font).to be_instance_of(Class)
    end
  end
end

module TooManyLevels
  describe Subsystem do
    it "does too much nesting!" do
      expect(
        Subsystem::Output::Rendering::GlyphSet::Font
      ).to be_instance_of(Class)
    end
  end
end
