
# By making Logger's method new private, we prevent anyone from creating a logging object using the conventional constructor

class Logger
  private_class_method :new
  @@logger = nil
  def Logger.create
    @@logger = new unless @@logger
    @@logger
  end
end

log1 = Logger.create
puts log1.object_id
log2 = Logger.create
puts log2.object_id

#The implementation of singletons that we present here is not thread-safe; if multiple threads were running, it would be possible to create multiple logger objects. Rather than add thread safety ourselves, however, we'd probably use the Singleton mixin supplied with Ruby
