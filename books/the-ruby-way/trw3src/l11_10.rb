class MyClass
  class << self
    def accessor_string(*names)
      names.each do |name|
        class_eval <<-EOF
          def #{name}
            @#{name}.to_s
          end
        EOF 
      end
    end 
  end

  def initialize
    @a = [1, 2, 3]
    @b = Time.now
  end

  accessor_string :a, :b
end
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼
￼￼￼￼
o = MyClass.new

puts o.a           # 123
puts o.b           # 2014-07-26 00:45:12 -0700
