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

module MustHappen
  include LoggingHelper
  extend self

  def log_before(description)
    logger.debug "Start: #{description}"
    begin
      yield
    rescue StandardError => e
      logger.error "Failed: #(description}: #{e}"
      raise
    end
  end


  def log_after(description)
    yield
    begin
      logger.debug "Completed #{description}"
    rescue StandardError => e
      logger.error "Failed: #(description}: #{e}"
      raise
    end
  end
end
