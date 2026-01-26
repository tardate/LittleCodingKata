#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "mod_printer_types"

module ModulizedPrinterTypes
  describe "object nature of modules" do
    it "means that you can have a var refer to a module" do
      admin_objects = []
      [true, false].each do |use_laser_printer|
        print_module = if use_laser_printer
                         TonsOToner
                       else
                         OceansOfInk
                       end

        # Later...
        admin = print_module::Administration.new
        admin_objects << admin
      end
      expect(admin_objects[0]).to be_instance_of(TonsOToner::Administration)
      expect(admin_objects[1]).to be_instance_of(OceansOfInk::Administration)
    end
  end
end
