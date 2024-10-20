# #043 Profiling

About memory profiling in Ruby.

## Notes

WIP: just dropping some unorganised notes for now..

### Get current ruby process memory usage

See also:

* [Get current ruby process memory usage (SO)](https://stackoverflow.com/questions/7220896/get-current-ruby-process-memory-usage)
* [os gem](https://rubygems.org/gems/os)

Running the [test_get_process_memory.rb](./test_get_process_memory.rb) script:

    $ ruby test_get_process_memory.rb
    RSS according to OS.rss_bytes: 17.5104 MB
    RSS according to ps: 17.522688 MB

### memory_profiler gem

* [memory_profiler gem](https://rubygems.org/gems/memory_profiler)
* [memory_profiler github](https://github.com/SamSaffron/memory_profiler)
* [Ruby on Rails Memory Profiling (2015)](https://thejspr.com/blog/ruby-on-rails-memory-profiling/)

### With NewRelic

<https://docs.newrelic.com/docs/agents/ruby-agent/features/developer-mode>
Developer mode is removed and no longer supported as of Ruby agent version 4.1.0.

Include the newrelic_rpm gem in your Gemfile and invoke it thus:

NewRelic::Agent::Samplers::MemorySampler.new.sampler.get_sample

## Credits and References

* [os gem](https://rubygems.org/gems/os)
* [memory_profiler gem](https://rubygems.org/gems/memory_profiler)
* [How do I track down a memory leak in my Ruby code? (SO)](https://stackoverflow.com/questions/20956401/how-do-i-track-down-a-memory-leak-in-my-ruby-code)
* [rack-mini-profiler - the Secret Weapon of Ruby and Rails Speed](https://www.speedshop.co/2015/08/05/rack-mini-profiler-the-secret-weapon.html)
* [Finding the cause of a memory leak in Ruby](https://stackoverflow.com/questions/20385767/finding-the-cause-of-a-memory-leak-in-ruby)
* [Memory-hungry Ruby daemons](http://www.mikeperham.com/2009/05/25/memory-hungry-ruby-daemons/)
* [Visualizing Your Ruby Heap](https://tenderlovemaking.com/2017/09/27/visualizing-your-ruby-heap.html)
