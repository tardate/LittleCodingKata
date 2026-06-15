class HashDup
  def initialize(*all)
    all.flatten!
    raise IndexError if all.size % 2 != 0
    @store = {}
    all.each do |key, val|
      self.store(key, val)
    end
  end

  def store(k, v)
    if @store.has_key?(k)
      @store[k] += [v]
    else
      @store[k] = [v]
    end
  end

  def [](key)
    @store[key]
  end

  def []=(key,value)
    self.store(key,value)
  end

  def to_s
    @store.to_s
  end

  def to_a
    @store.to_a
  end
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼
  def inspect
    @store.inspect
  end

  def keys
    result=[]
    @store.each do |k,v|
      result += ([k]*v.size)
    end
    result 
  end

  def values
    @store.values.flatten
  end

  def each
    @store.each {|k,v| v.each {|y| yield k, y }}
  end

  alias each_pair each

  def each_key
    self.keys.each {|k| yield k }
  end

  def each_value
    self.values.each {|v| yield v }
  end

  def has_key? k
  self.keys.include? k
  end

  def has_value? v
    self.values.include? v
  end

  def length
    self.values.size
  end

  alias size length

  def delete(k)
    val = @store[k]
    @store.delete k
    val
  end

  def delete(k,v)
    @store[k] -= [v] if @store[k]
    v 
  end

  # Other methods omitted here...
end

# This won't work... dup key will ignore
# first occurrence.
h = {1 => 1, 2 => 4, 3 => 9, 4 => 16, 2 => 0}

# This will work...
h = HashDup.new(1,1, 2,4, 3,9, 4,16, 2,0)
k = h.keys    # [4, 1, 2, 2, 3]
v = h.values  # [16, 1, 4, 0, 9]
n = h.size    # 5

h.each {|k,v| puts "#{k} => #{v}"}

# Prints:
# 4 => 16
# 1 => 1
# 2 => 4
# 2 => 0
# 3 => 9
