module Tracing
  def self.hook_method(const, meth)
    const.class_eval do
      alias_method "untraced_#{meth}", "#{meth}"
      define_method(meth) do |*args|
        puts "#{meth} called with params (#{args.join(‘, ‘)})"
        send("untraced_#{meth}",*args)
      end
    end 
  end

  def self.included(const)
    const.instance_methods(false).each do |m|
      hook_method(const, m)
    end

    def const.method_added(name)
      return if @disable_method_added
      puts "The method #{name} was added to class #{self}"
      @disable_method_added = true
      Tracing.hook_method(self, name)
      @disable_method_added = false
    end

    if const.is_a?(Class)
      def const.inherited(name)
        puts "The class #{name} inherited from #{self}"
      end
    end
    if const.is_a?(Module)
      def const.extended(name)
        puts "The class #{name} extended itself with #{self}"
      end

      def const.included(name)
        puts "The class #{name} included #{self} into itself"
      end 
    end

    def const.singleton_method_added(name, *args)
      return if @disable_singleton_method_added
      return if name == :singleton_method_added
      puts "The class method #{name} was added to class #{self}"
      @disable_singleton_method_added = true
      singleton_class = (class << self; self; end)
      Tracing.hook_method(singleton_class, name)
      @disable_singleton_method_added = false
    end
  end
end
