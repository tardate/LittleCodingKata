#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
#require_relative '../common/document'

module ModulizedPrinterTypes
  module TonsOToner
    class PrintQueue
      def submit(print_job)
        # Send the job off for printing to this laser printer
      end
  
      def cancel(print_job)
        # Stop!
      end
    end
  
    class Administration
      def power_off
        # Turn this laser printer off...
      end
  
      def start_self_test
        # Everything ok?
      end
    end
  end


  module OceansOfInk
    class PrintQueue
      def submit(print_job)
        # Send the job off for printing to this ink jet printer
      end
      # Rest omitted...
    end
  
    class Administration
      #  Ink jet administration code omitted...
    end
  end
end
