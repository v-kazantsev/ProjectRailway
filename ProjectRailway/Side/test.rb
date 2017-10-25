require 'test_module'
class Dog
  @@instances = 0
  class << self
    def instances
      @@instances
    end
    def instances=(instances)
      @@instances = instances
    end
  end
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  
  def initialize
   register_instance
  end

end