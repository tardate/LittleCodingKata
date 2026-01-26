#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative '../common/document'

module ExposedPrinterTypes
  class TonsOTonerPrintQueue
    def submit(print_job)
      # Send the job off for printing to this laser printer...
    end
  
    def cancel(print_job)
      # Stop the print job on this laser printer...
    end
  end
  
  class TonsOTonerAdministration
    def power_off
      # Turn this laser printer off...
    end
  
    def start_self_test
      # Test this laser printer...
    end
  end
  

  class OceansOfInkPrintQueue
    # Similar submit and cancel methods...
    
    def submit(print_job)
    end
    def cancel(print_job)
    end 
  end
  
  class OceansOfInkAdministration
    # Similar power_off and start_self_test methods...
    
    def power_off
    end
  
    def start_self_test
    end 
  end
end
