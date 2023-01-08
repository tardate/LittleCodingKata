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
