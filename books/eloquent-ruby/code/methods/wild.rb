#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---

# See: https://github.com/rspec/rspec-core/blob/aec5f49485d97908183dbe790a7fefb8baaa8091/lib/rspec/core/example.rb#L478C1-L496C10

=begin
def finish(reporter)
  pending_message = execution_result.pending_message

  if @exception
    execution_result.exception = @exception
    record_finished :failed, reporter
    reporter.example_failed self
    false
  elsif pending_message
    execution_result.pending_message = pending_message
    record_finished :pending, reporter
    reporter.example_pending self
    true
  else
    record_finished :passed, reporter
    reporter.example_passed self
    true
  end
end
=end

