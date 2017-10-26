module InstanceCounter 
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    
    attr_reader :instances
    def instances_up
      @instances ||= 0
      @instances +=1
    end
  end
  
  private
  def register_instance
    self.class.instances_up
  end
end