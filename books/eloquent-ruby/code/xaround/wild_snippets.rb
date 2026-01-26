#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
=begin
# See https://github.com/lostisland/faraday/blob/bbaa093dbc629b697ce4b6dee4cd882d0eef80d1/docs/getting-started/quick-start.md?plain=1#L131

response = conn.post('post') do |req|
  req.params['limit'] = 100
  req.headers['Content-Type'] = 'application/json'
  req.body = {query: 'chunky bacon'}.to_json
end


# See https://github.com/rails/rails/blob/b7520a13adda46c0cc5f3fb4a4c1726633af2bba/activerecord/lib/active_record/migration.rb#L1016

    # Takes a message argument and outputs it as is.
    # A second boolean argument can be passed to specify whether to indent or not.
    def say(message, subitem = false)
      write "#{subitem ? "   ->" : "--"} #{message}"
    end

    # Outputs text along with how long it took to run its block.
    # If the block returns an integer it assumes it is the number of rows affected.
    def say_with_time(message)
      say(message)
      result = nil
      time_elapsed = ActiveSupport::Benchmark.realtime { result = yield }
      say "%.4fs" % time_elapsed, :subitem
      say("#{result} rows", :subitem) if result.is_a?(Integer)
      result
    end
=end
