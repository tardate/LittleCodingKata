#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---

# See: https://github.com/test-unit/test-unit/blob/572b28afa0b387707dcb1229d2b96ba130f95f11/lib/test/unit.rb#L516
#
=begin
at_exit do
  if $!.nil? and Test::Unit::AutoRunner.need_auto_run?
    exit Test::Unit::AutoRunner.run
  end
end
=end
