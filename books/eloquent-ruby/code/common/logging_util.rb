#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "logger"

# Fake IO class, used to make Logger instances play nicely
# with RSpec features like to_output. It turns out that
# the default Logger behavior writes to stdout in such a way
# that RSpec doesn't see the output. This class fixes that 
# by writing the logging output to stdout using puts.
#
# @example
#
# logger = Logger.new(LoggerIO.new)
# logger.debug("This goes to stdout!")
#
class LoggerIO
  def write(string)
    puts(string)
    string.length
  end

  def close
  end
end

# Mix in module that supplies a `logger` method.
#
# @example
#
# class Foo
#   include LoggingHelper
#
#   def do_something
#     logger.debug("It works!")
#   end
# end
#
module LoggingHelper
  def logger
    @logger = Logger.new(LoggerIO.new) unless @logger
    @logger
  end
end

