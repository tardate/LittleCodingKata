#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/logging_util"
require_relative "../common/document"

module Answers
  include LoggingHelper
  extend self

  def with_logging(description)
    logger.debug "Starting #{description}"
    return_value = yield
    logger.debug "Completed #{description}"

    return_value
  rescue StandardError => e
    logger.error "#{description} failed: #{e}"
    raise
  end

  #
  def do_something_silly
    # Expecting this to return the result of the block!

    kms = with_logging "Compute km in a light year" do
      300_000 * 60 * 60 * 24 * 365
    end

    # Do something interesting with all those kilometers...
  end

  def time_execution
    t0 = Time.now
    result = yield
    t1 = Time.now

    execution_time = t1-t0
    return {execution_time:, result:}
  end
end

