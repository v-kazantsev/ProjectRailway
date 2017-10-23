require_relative "class_train"
class Station
  
  attr_accessor :trains 
  attr_reader :name


  def initialize(name)       
    @name = name
    @trains = []    
  end

  def train_in(train)       
    self.trains << train          
  end

  def train_out(train)     
    trains.delete(train)     
  end

  def train_type_list(type)             
    trains.count { |t| t.type == type }
  end

end
