require 'sinatra'
require 'time'

# bind to all interfaces, else just binds to localhost.
set :bind, '0.0.0.0'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

class Counters
  @get_request_count = 0

  def self.get_request_count
    @get_request_count += 1
  end
end

# Return some fake prometheus metrics
get '/metrics' do
  timestamp = (Time.now.to_f * 1000).to_i
  gc_stats = GC.stat

  content_type 'text/plain'
  <<-EOM
# HELP http_requests_total The total number of HTTP requests.
# TYPE http_requests_total counter
http_requests_total{app="sinatra_target",method="get",code="200"} #{Counters.get_request_count} #{timestamp}

# HELP gc_heap_slots_count Current GC heap slots.
# TYPE gc_heap_slots_count gauge
gc_heap_slots_count{app="sinatra_target",status="available"} #{gc_stats[:heap_available_slots]} #{timestamp}
gc_heap_slots_count{app="sinatra_target",status="live"} #{gc_stats[:heap_live_slots]} #{timestamp}
gc_heap_slots_count{app="sinatra_target",status="free"} #{gc_stats[:heap_free_slots]} #{timestamp}
gc_heap_slots_count{app="sinatra_target",status="final"} #{gc_stats[:heap_final_slots]} #{timestamp}
gc_heap_slots_count{app="sinatra_target",status="marked"} #{gc_stats[:heap_marked_slots]} #{timestamp}

# HELP gc_objects_total Total GC object operations.
# TYPE gc_objects_total counter
gc_objects_total{app="sinatra_target",status="allocated"} #{gc_stats[:total_allocated_objects]} #{timestamp}
gc_objects_total{app="sinatra_target",status="freed"} #{gc_stats[:total_freed_objects]} #{timestamp}

# HELP gc_pages_total Total GC page operations.
# TYPE gc_pages_total counter
gc_pages_total{app="sinatra_target",status="allocated"} #{gc_stats[:total_allocated_pages]} #{timestamp}
gc_pages_total{app="sinatra_target",status="freed"} #{gc_stats[:total_freed_pages]} #{timestamp}
  EOM
end

# everything else shows the main page
get '/*' do
  erb :index
end
