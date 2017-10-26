module InstanceCounter
@@instances = 0  
  def register_instance
    @@instances += 1
    self.class.instances = @@instances
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    @instances = 0
    attr_accessor :instances
  end
end