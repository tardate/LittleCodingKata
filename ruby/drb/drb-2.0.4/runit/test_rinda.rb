require 'drb/drb'
require 'drb/eq'
require 'runit/testcase'
require 'runit/cui/testrunner'
require 'rinda/tuplespace'

class TupleSpaceTest < RUNIT::TestCase
  def test_00_tuple
    tuple = Rinda::TupleEntry.new([1,2,3])
    assert(!tuple.canceled?)
    assert(!tuple.expired?)
    assert(tuple.alive?)
  end

  def test_00_template
    tmpl = Rinda::Template.new([1,2,3])
    assert_equal(3, tmpl.size)
    assert_equal(3, tmpl[2])
    assert(tmpl.match([1,2,3]))
    assert(!tmpl.match([1,nil,3]))
    
    tmpl = Rinda::Template.new([/^rinda/i, nil, :hello])
    assert_equal(3, tmpl.size)
    assert(tmpl.match(['Rinda', 2, :hello]))
    assert(!tmpl.match(['Rinda', 2, Symbol]))
    assert(!tmpl.match([1, 2, :hello]))

    tmpl = Rinda::Template.new([Symbol])
    assert_equal(1, tmpl.size)
    assert(tmpl.match([:hello]))
    assert(!tmpl.match([Symbol]))
    assert(!tmpl.match(['Symbol']))

    tmpl = Rinda::Template.new({"message"=>String, "name"=>String})
    assert_equal(2, tmpl.size)
    assert(tmpl.match({"message"=>"Hello", "name"=>"Foo"}))
    assert(tmpl.match({"message"=>"Hello", "name"=>"Foo", 1=>2}))
    assert(tmpl.match({"message"=>"Hi", "name"=>"Foo", :name=>1}))
    assert(!tmpl.match({"message"=>"Hello", "no_name"=>"Foo"}))

    tmpl = Rinda::Template.new({:message=>String, "name"=>String})
    assert_equal(1, tmpl.size)
    assert(tmpl.match({"message"=>"Hello", "name"=>"Foo"}))
    assert(tmpl.match({"message"=>:symbol, "name"=>"Foo", 1=>2}))
    assert(tmpl.match({"message"=>"Hi", "name"=>"Foo", :name=>1}))
    assert(!tmpl.match({"message"=>"Hello", "no_name"=>"Foo"}))

    tmpl = Rinda::Template.new({"message"=>String, "name"=>String, :size=>2})
    assert_equal(2, tmpl.size)
    assert(tmpl.match({"message"=>"Hello", "name"=>"Foo"}))
    assert(!tmpl.match({"message"=>"Hello", "name"=>"Foo", 1=>2}))
    assert(!tmpl.match({"message"=>"Hi", "name"=>"Foo", :name=>1}))
    assert(!tmpl.match({"message"=>"Hello", "no_name"=>"Foo"}))
  end

  def test_00_DRbObject
    ro = DRbObject.new(nil, "druby://host:1234")
    tmpl = Rinda::DRbObjectTemplate.new
    assert(tmpl === ro)

    tmpl = Rinda::DRbObjectTemplate.new("druby://host:1234")
    assert(tmpl === ro)

    tmpl = Rinda::DRbObjectTemplate.new("druby://host:12345")
    assert(!(tmpl === ro))

    tmpl = Rinda::DRbObjectTemplate.new(/^druby:\/\/host:/)
    assert(tmpl === ro)

    ro.reinit(12345, 1234)
    assert(!(tmpl === ro))

    ro.reinit("druby://foo:12345", 1234)
    assert(!(tmpl === ro))

    tmpl = Rinda::DRbObjectTemplate.new(/^druby:\/\/(foo|bar):/)
    assert(tmpl === ro)

    ro.reinit("druby://bar:12345", 1234)
    assert(tmpl === ro)

    ro.reinit("druby://baz:12345", 1234)
    assert(!(tmpl === ro))
  end

  def test_core_01
    @ts = Rinda::TupleSpace.new(1)

    5.times do |n|
      @ts.write([:req, 2])
    end

    assert_equal([[:req, 2], [:req, 2], [:req, 2], [:req, 2], [:req, 2]],
		 @ts.read_all([nil, nil]))

    taker = Thread.new do
      s = 0
      while true
	begin
	  tuple = @ts.take([:req, Integer], 0.5)
	  assert_equal(2, tuple[1])
	  s += tuple[1]
	rescue Rinda::RequestExpiredError
	  break
	end
      end
      @ts.write([:ans, s])
      s
    end

    tuple = @ts.take([:ans, nil], 20)
    assert_equal(10, tuple[1])
    assert_equal(10, taker.value)
  end

  def test_core_02
    @ts = Rinda::TupleSpace.new(1)

    taker = Thread.new do
      s = 0
      while true
	begin
	  tuple = @ts.take([:req, Integer], 0.5)
	  assert_equal(2, tuple[1])
	  s += tuple[1]
	rescue Rinda::RequestExpiredError
	  break
	end
      end
      @ts.write([:ans, s])
      s
    end

    5.times do |n|
      @ts.write([:req, 2])
    end

    tuple = @ts.take([:ans, nil], 20)
    assert_equal(10, tuple[1])
    assert_equal(10, taker.value)
    assert_equal([], @ts.read_all([nil, nil]))
  end
  
  def test_core_03_notify
    @ts = Rinda::TupleSpace.new(1)

    notify1 = @ts.notify(nil, [:req, Integer])
    notify2 = @ts.notify(nil, [:ans, Integer], 5)
    notify3 = @ts.notify(nil, {"message"=>String, "name"=>String}, 5)

    @ts.write({"message"=>"first", "name"=>"3"}, 3)
    @ts.write({"message"=>"second", "name"=>"1"}, 1)
    @ts.write({"message"=>"third", "name"=>"0"})
    @ts.take({"message"=>"third", "name"=>"0"})

    listener1 = Thread.new do
      lv = 0
      n = 0
      notify1.each  do |ev, tuple|
	n += 1
	if ev == 'write'
	  lv = lv + 1
	elsif ev == 'take'
	  lv = lv - 1
	else
	  break
	end
	assert(lv >= 0)
	assert_equal([:req, 2], tuple)
      end
      [lv, n]
    end

    listener2 = Thread.new do
      result = nil
      lv = 0
      n = 0
      notify2.each  do |ev|
	n += 1
	if ev[0] == 'write'
	  lv = lv + 1
	elsif ev[0] == 'take'
	  lv = lv - 1
	elsif ev[0] == 'close'
	  result = [lv, n]
	else
	  break
	end
	assert(lv >= 0)
	assert_equal([:ans, 10], ev[1])
      end
      result
    end

    taker = Thread.new do
      s = 0
      while true
	begin
	  tuple = @ts.take([:req, Integer], 0.5)
	  s += tuple[1]
	rescue Rinda::RequestExpiredError
	  break
	end
      end
      @ts.write([:ans, s])
      s
    end

    writer = Thread.new do
      5.times do |n|
	@ts.write([:req, 2])
	sleep 0.1
      end
    end

    @ts.take({"message"=>"first", "name"=>"3"})

    tuple = @ts.take([:ans, nil], 20)
    assert_equal(10, tuple[1])
    assert_equal(10, taker.value)
    assert_equal([], @ts.read_all([nil, nil]))
    
    notify1.cancel
    sleep(3) # notify2 expired
    
    assert_equal([0, 11], listener1.value)
    assert_equal([0, 3], listener2.value)

    ary = []
    ary.push(["write", {"message"=>"first", "name"=>"3"}])
    ary.push(["write", {"message"=>"second", "name"=>"1"}])
    ary.push(["write", {"message"=>"third", "name"=>"0"}])
    ary.push(["take", {"message"=>"third", "name"=>"0"}])
    ary.push(["take", {"message"=>"first", "name"=>"3"}])
    ary.push(["delete", {"message"=>"second", "name"=>"1"}])
    ary.push(["close"])

    notify3.each do |ev|
      assert_equal(ary.shift, ev)
    end
    assert_equal([], ary)
  end
  
  def test_cancel_01
    @ts = Rinda::TupleSpace.new(1)

    entry = @ts.write([:removeme, 1])
    assert_equal([[:removeme, 1]], @ts.read_all([nil, nil]))
    entry.cancel
    assert_equal([], @ts.read_all([nil, nil]))
    
    template = nil
    taker = Thread.new do
      @ts.take([:take, nil], 10) do |template|
	Thread.new do
	  sleep 0.2
	  template.cancel
	end
      end
    end
    
    sleep 1
    assert(template.canceled?)
    
    @ts.write([:take, 1])

    assert_exception(Rinda::RequestCanceledError) do
      assert_nil(taker.value)
    end

    assert_equal([[:take, 1]], @ts.read_all([nil, nil]))
  end

  def test_cancel_02
    @ts = Rinda::TupleSpace.new(1)

    entry = @ts.write([:removeme, 1])
    assert_equal([[:removeme, 1]], @ts.read_all([nil, nil]))
    entry.cancel
    assert_equal([], @ts.read_all([nil, nil]))

    template = nil
    reader = Thread.new do
      @ts.read([:take, nil], 10) do |template|
	Thread.new do
	  sleep 0.2
	  template.cancel
	end
      end
    end
    
    sleep 1
    assert(template.canceled?)
    
    @ts.write([:take, 1])

    assert_exception(Rinda::RequestCanceledError) do
      assert_nil(reader.value)
    end

    assert_equal([[:take, 1]], @ts.read_all([nil, nil]))
  end

  class SimpleRenewer
    def initialize(sec, n = 1)
      @sec = sec
      @n = n
    end
    
    def renew
      return -1 if @n <= 0
      @n -= 1
      return @sec
    end
  end

  def test_00_renewer
    tuple = Rinda::TupleEntry.new([1,2,3], true)
    assert(!tuple.canceled?)
    assert(tuple.expired?)
    assert(!tuple.alive?)
    
    tuple = Rinda::TupleEntry.new([1,2,3], 1)
    assert(!tuple.canceled?)
    assert(!tuple.expired?)
    assert(tuple.alive?)
    sleep(2)
    assert(tuple.expired?)
    assert(!tuple.alive?)

    tuple = Rinda::TupleEntry.new([1,2,3], SimpleRenewer.new(1,2))
    assert(!tuple.canceled?)
    assert(!tuple.expired?)
    assert(tuple.alive?)
    sleep(1.5)
    assert(!tuple.canceled?)
    assert(!tuple.expired?)
    assert(tuple.alive?)
    sleep(1.5)
    assert(tuple.expired?)
    assert(!tuple.alive?)
  end
end

if __FILE__ == $0
  RUNIT::CUI::TestRunner.run(TupleSpaceTest.suite)
end
