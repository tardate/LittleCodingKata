#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/logging_util"
require_relative "doc_with_load_save"

module RedundantArgument
  include LoggingHelper
  extend self

  # A misguided attempt to deliver data to the block.

  def upcase_document(old_path, new_path)
    doc = Document.load(old_path)

    doc.content.upcase!

    with_logging("save", doc) do |the_object|
      the_object.save(new_path)
    end
  end

  def with_logging(description, the_object)
    logger.debug "Starting #{description}"
    yield(the_object)
    logger.debug "Complete #{description}"
  rescue StandardError => e
    logger.error "#{description} failed: #{e}"
    raise
  end
end

module BlocksAreClosures
  include LoggingHelper
  extend self

  def upcase_document(old_path, new_path)
    doc = Document.load(old_path)

    doc.content.upcase!

    with_logging("save") do
      # doc is visible inside of the block.
      doc.save(new_path)
    end
  end

  # Back to original with_logging.
  def with_logging(description)
    logger.debug "Starting #{description}"
    yield
    logger.debug "Complete #{description}"
  rescue StandardError => e
    logger.error "#{description} failed: #{e}"
    raise
  end
end


module MethodGeneratedArgument
  extend self
  
  def with_database_connection(connection_info)
    connection = Database.new(connection_info)
    yield connection
  ensure
    connection.close
  end
end
