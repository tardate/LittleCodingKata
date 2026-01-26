#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "find"
require_relative "rawk_3"

module Version4
  class Rawk < Version3::Rawk; end

  class Rawk
    # Rest of the class omitted...

    def self.setup(rawk_script:, path:)
      rawk = Rawk.new
      rawk.instance_eval(rawk_script, path)
      rawk
    end

    def self.setup_from_file(rawk_script_path)
      script = File.read(rawk_script_path)
      setup(rawk_script: script, path: rawk_script_path)
    end
  end
end
