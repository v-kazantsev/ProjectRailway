module InstanceCounter
  module ClassMethods

    def instances
      @@instances
    end

  end 

  module InstanceMethods
    
    protected
    def register_instance
      self.class.instances += 1
    end
  
  end
end
