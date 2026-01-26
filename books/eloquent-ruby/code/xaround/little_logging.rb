#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"
require_relative "../common/logging_util"

module Rot13
  # World's weakest encryption.
  def rot13(clear)
    clear.tr("a-zA-Z", "n-za-mN-ZA-M")
  end

end


module Basic
  extend self
  include Rot13
  include LoggingHelper

  # Load a document from the database, encrypt the content
  # and save it back.
  def encrypt_document(db, doc_id)
    doc = db.load(doc_id)
    doc.content = rot13(doc.content)
    db.save(doc_id, doc)
  end
end

module AddLogging
  extend self
  include Rot13
  include LoggingHelper

  def encrypt_document(db, doc_id, logger)
    logger.debug "Start: document load."
    doc = db.load(doc_id)
    logger.debug "Complete: document load."

    doc.content = rot13(doc.content)

    logger.debug "Start: document save."
    db.save(doc_id, doc)
    logger.debug "Complete: document save."
  end
end

module Disaster
  extend self
  include Rot13
  include LoggingHelper

  def encrypt_document(db, doc_id, logger)
    begin
      logger.debug "Start: document load."
      doc = db.load(doc_id)
      logger.debug "Complete: document load."
    rescue StandardError => e
      logger.error "Failed: document load: #{e}"
      raise
    end

    doc.content = rot13(doc.content)

    begin
      logger.debug "Start: document save."
      db.save(doc_id, doc)
      logger.debug "Complete: document save."
    rescue StandardError => e
      logger.error "Failed: document save: #{e}."
      raise
    end
  end
end

module LoadSaveLogging
  extend self
  include Rot13
  include LoggingHelper

  def encrypt_document(db, doc_id, logger)
    doc = load_with_logging(db, doc_id, logger)
    doc.content = rot13(doc.content)
    save_with_logging(db, doc_id, doc)
  end

  def load_with_logging(db, doc_id, logger)
    logger.debug "Start: document load."
    doc = db.load(doc_id)
    logger.debug "Complete: document load."
    doc
  rescue StandardError => e
    logger.error "Failed: document load: #{e}"
    raise
  end

  def save_with_logging(db, doc_id, doc)
    logger.debug "Start: document save."
    db.save(doc_id, doc)
    logger.debug "Complete: document save."
  rescue StandardError => e
    logger.error "Failed: document save: #{e}"
    raise
  end
end


module WithLogging
  extend self
  include Rot13
  include LoggingHelper

  def encrypt_document(db, doc_id, logger)
    # Make sure doc is in scope throuhout this method.
    doc = nil

    with_logging "document load" do
      doc = db.load(doc_id)
    end

    doc.content = rot13(doc.content)

    with_logging "document save" do
      db.save(doc_id, doc)
    end
  end

  def with_logging(description)
    logger.debug "Start: #{description}."
    yield
    logger.debug "Complete: #{description}."
  rescue StandardError => e
    logger.error "Failed: #{description}: #{e}"
    raise
  end

  def do_something_silly
    with_logging "Compute km in a light year" do
      300_000 * 60 * 60 * 24 * 365
    end
  end
end
