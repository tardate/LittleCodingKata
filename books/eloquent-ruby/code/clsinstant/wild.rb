#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
=begin
@See: https://github.com/heartcombo/devise/blob/cf93de390a29654620fdf7ac07b4794eb95171d0/lib/devise.rb#L11

module Devise
 
  # ...
  @@secret_key = nil

  # ...
  @@authentication_keys = [:email]
  
  # ...
  @@email_regexp = /\A[^@\s]+@[^@\s]+\z/
end
=end
