
# fix dictionary handling in radiustar
module Radiustar
  class Dictionary
    def set_value(line)
      @attributes.find_by_name(line[1]).add_value(line[2], line[3])
    rescue NoMethodError
      puts "missing attribute for line: #{line}"
    end
  end
  class AttributesCollection
    def find_by_name(name)
      @collection.find { |k, _| k.casecmp?(name) }&.last
    end
  end
end
