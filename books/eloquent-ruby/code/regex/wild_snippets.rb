#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---

=begin
# See: https://github.com/rails/rails/blob/3235827585d87661942c91bc81f64f56d710f0b2/activerecord/lib/active_record/log_subscriber.rb#L88

# Yes! You can use regular expressions in your case statements
# and they do exactly what you want them to do.

def sql_color(sql)
  case sql
  when /\A\s*rollback/mi
    RED
  when /select .*for update/mi, /\A\s*lock/mi
    WHITE
  when /\A\s*select/i
    BLUE
  when /\A\s*insert/i
    GREEN
  when /\A\s*update/i
    YELLOW
  when /\A\s*delete/i
    RED
  when /transaction\s*\Z/i
    CYAN
  else
    MAGENTA
  end
end
=end

=begin
# See https://github.com/ruby/ruby/blob/ea8b53a53954c2f34b1093ae2547951ae0e1fe8c/lib/uri/mailto.rb#L148

  unless /\A(?:[^@,;]+@[^@,;]+(?:\z|[,;]))*\z/ =~ to
    raise InvalidComponentError,
      "unrecognised opaque part for mailtoURL: #{@opaque}"
  end
=end

=begin
# See https://github.com/ruby/ruby/blob/ea8b53a53954c2f34b1093ae2547951ae0e1fe8c/lib/uri/mailto.rb#L174

  # check url safety as path-rootless
  if /\A(?:%\h\h|[!$&-.0-;=@-Z_a-z~])*\z/ !~ addr
    raise InvalidComponentError,
      "an address in 'to' is invalid as URI #{addr.dump}"
  end
=end