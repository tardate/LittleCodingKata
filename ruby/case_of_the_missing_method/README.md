# The Case of the Missing Method

Or to mix literary metaphors, where in the world do class methods get stored? An investigation into the sublime and elegant design of metaclasses in ruby.

## Notes

I heard about
[Nadia Odunayo](https://www.nadiaodunayo.com/)'s brilliant talk
[The Case of the Missing Method: A Ruby Mystery Story](https://www.youtube.com/watch?v=d3KA45vA6Hw)
from the
[Chats in the Cupboard](https://chatsinthecupboard.com/s02e04-conferences/)
podcast.

This particular talk (which is a master class in designing and presenting a talk in its own right)
introduced us to the mysterious
[singleton_class](https://apidock.com/ruby/Object/singleton_class) in ruby.

Every Class has an associated Singleton Class, and this is where class methods are defined (not in the class itself).

As Nadia explains, this approach is a good example of the minimalist and elegant design of ruby itself:

* "class methods" are implemented under the cover as just plain old "instance methods" defined on a Singleton Class.
* and the Singleton Class is just a plain old class that just happen to be defined as the `singleton_class` instance variable of the class in question.

This topic is also covered in "Experiment 5-2: Where Does Ruby Save Class Methods?", page 127 of
[Ruby Under a Microscope](https://www.goodreads.com/book/show/16300795-ruby-under-a-microscope) by Pat Shaughnessy.

### Nadia Odunayo - The Case of the Missing Method: A Ruby Mystery Story

[![clip](https://img.youtube.com/vi/d3KA45vA6Hw/0.jpg)](https://www.youtube.com/watch?v=d3KA45vA6Hw)

### Exploring the Ideas

See [example.rb](./example.rb) for code notes from the talk...

```ruby
$ cat example.rb
#! /usr/bin/env ruby
require 'minitest/autorun'

class Cake
  def initialize(flavour)
    @flavour = flavour
  end

  def tasty?
    @flavour == 'carrot'
  end

  def self.edible?
    true
  end
end

class CaseOftheMissingMethod < Minitest::Test
  def setup
    @carrot_cake = Cake.new('carrot')
    @mud_cake = Cake.new('mud')
  end

  def test_carrot_cakes_are_tasty
    assert @carrot_cake.tasty?
  end

  def test_other_cakes_are_not_tasty
    assert !@mud_cake.tasty?
  end

  def test_all_cakes_are_edible
    assert @carrot_cake.class.edible?
    assert @mud_cake.class.edible?
  end

  def test_instance_methods_are_defined_on_the_class
    assert Cake.instance_methods.include?(:tasty?)
  end

  def test_class_methods_are_not_defined_on_the_class
    assert !Cake.instance_methods.include?(:edible?)
  end

  def test_class_has_superclass_and_singleton_class
    assert_equal 'Cake', Cake.to_s
    assert_equal 'Object', Cake.superclass.to_s
    assert_equal '#<Class:Cake>', Cake.singleton_class.to_s
  end

  def test_class_ancestors_does_not_include_the_singleton_class
    assert_equal [Cake, Object, Minitest::Expectations, Kernel, BasicObject], Cake.ancestors
    assert Cake.ancestors.include?(BasicObject)
    assert !Cake.ancestors.include?(Cake.singleton_class)
  end

  def test_class_methods_are_defined_on_the_singleton_class
    assert Cake.singleton_class.instance_methods.include?(:edible?)
  end
end
```

Results of course:

```bash
$ ./example.rb
Run options: --seed 51067

# Running:

........

Finished in 0.002050s, 3902.4391 runs/s, 6341.4636 assertions/s.

8 runs, 13 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [The Case of the Missing Method: A Ruby Mystery Story](https://www.youtube.com/watch?v=d3KA45vA6Hw) - [Nadia Odunayo](https://www.nadiaodunayo.com/)
* [Ruby Under a Microscope](https://www.goodreads.com/book/show/16300795-ruby-under-a-microscope) - Pat Shaughnessy
* [Ruby, Smalltalk and Class Variables](https://patshaughnessy.net/2012/12/17/ruby-smalltalk-and-class-variables) - Pat Shaughnessy
* [Episode #453: Singleton Class](https://www.rubytapas.com/2016/10/31/episode-453-singleton-class/) - Avdi Grimm
* [Episode #454: Class Method](https://www.rubytapas.com/2016/11/09/episode-454-class-method/) - Avdi Grimm
* [Episode #456: Singleton Class Exec](https://www.rubytapas.com/2016/11/21/episode-456-singleton-class-exec/) - Avdi Grimm
* [Benefits of Writing a DSL in Ruby](https://engineering.gusto.com/benefits-of-writing-a-dsl/) - Gusto
* [DSL Q & A](https://martinfowler.com/bliki/DslQandA.html) - Martin Fowler
* [Eigen What Now?](https://brightonruby.com/2017/eigen-what-now-eliza-de-jager/) - Eliza de Jager
* [singleton_class](https://apidock.com/ruby/Object/singleton_class) - ruby apidock
