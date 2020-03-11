def memoize(name)
  cache = {}

  (class<<self; self; end).send(:define_method, name) do |*args|
    unless cache.has_key?(args)
      cache[args] = super(*args)
    end
    cache[args]
  end
  cache
end

require './runner.rb'
run
