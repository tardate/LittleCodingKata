#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# Adapted from TBD
module YARD
  class Logger
    module Severity
      DEBUG = 0
      INFO = 1
      WARN = 2
      ERROR = 3
      FATAL = 4
      UNKNOWN = 5
    end
  end

  class Logger
    def log(severity, message)
      puts "LOG/#{severity}: #{message}"
    end
  end
end

module YARD
  class Logger
    # Lots of code omitted.

    def self.create_log_method(name)
      severity = Severity.const_get(name.to_s.upcase)
      define_method(name) { |message| log(severity, message) }
    end

    # More code omitted...
  end
end

module YARD
  class Logger
    # Later that day...

    create_log_method :info
    create_log_method :error
    create_log_method :fatal
    create_log_method :unknown  
    # ...
    create_log_method :debug
    # ...
    create_log_method :warn
  end
end

module YARD
  class Logger
    def info(message)
      log(Severity::INFO, message)
    end
  end
end
