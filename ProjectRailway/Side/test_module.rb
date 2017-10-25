module InstanceCounter
  module ClassMethods

    def instances
      puts @@instances
    end

  end 

  module InstanceMethods
    
    protected
    def register_instance
      instances += 1
    end
  
  end
end



