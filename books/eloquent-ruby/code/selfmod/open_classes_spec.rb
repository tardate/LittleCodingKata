#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

module CodeInClassDefinition
  describe "class definition" do
    it "executes the code inside the definition" do
      expect do
        class MostlyEmpty
          puts "Hello from inside the class."
        end
      end.to output(/Hello from/).to_stdout
    end

    it "makes self the class inside the definition" do
      expect do
        class SlightlyLessEmpty
          puts "The value of self is #{self}."
        end
      end.to output(/The value.*SlightlyLessEmpty/).to_stdout
    end

    it "defines methods in sequence" do
      expect do
        class NotEmptyAtAll
          pp instance_methods(false)

          def do_something
            puts "I'm doing something!"
          end

          pp instance_methods(false)
        end
      end.to output(/\[\].*\[:do_something\]/m).to_stdout
    end

    it "enables your to override method definitions" do
      expect do
        class TheSameMethodTwice
          def do_something
            puts "The first version."
          end

          # In between method definitions

          def do_something
            puts "The second version."
          end
        end

        twice = TheSameMethodTwice.new
        twice.do_something
      end.to output(/The second version/).to_stdout
    end
  end
end

module MonkeyPatching
  class TheSameMethodTwice
    def do_something
      puts "The first version."
    end
  end
  
  class TheSameMethodTwice
    def do_something
      puts "The second version."
    end
  end

  describe TheSameMethodTwice do
    it "picks up the last version of the method" do
      expect do
        twice = TheSameMethodTwice.new
        twice.do_something
      end.to output(/The second version/).to_stdout
    end
  end
end
