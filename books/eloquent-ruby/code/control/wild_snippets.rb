#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# See https://github.com/rspec/rspec-core/blob/aec5f49485d97908183dbe790a7fefb8baaa8091/lib/rspec/core/example.rb#L76


def description
  description = if metadata[:description].to_s.empty?
                  location_description
                else
                  metadata[:description]
                end
  # Remainder of the method, which uses description, omitted.
end


# See https://github.com/ruby/ruby/blob/fab133e629c507f4add4a7dde2e0ba12b7ec281c/lib/rubygems/doctor.rb#L118C7-L118C59

=begin
type = File.directory?(child) ? "directory" : "file"
=end

# See https://github.com/rails/rails/blob/65014e2379546e25407e87e5b3a056e0460361c7/activerecord/lib/active_record/asynchronous_queries_tracker.rb#L60

=begin
session&.finalize(wait)
=end

# See https://github.com/rails/rails/blob/65014e2379546e25407e87e5b3a056e0460361c7/actionpack/lib/action_controller/metal/exceptions.rb#L43

=begin
routes&.named_routes&.helper_names&.grep(/#{route_name}/)
=end