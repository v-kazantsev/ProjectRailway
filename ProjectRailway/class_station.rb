require_relative "class_train"
class Station
  
  attr_accessor :trains 
  attr_reader :name

  @@all_stations = []

  def self.all                                     
    @@all_stations
  end                                             

  def initialize(name)       
    @name = name
    @trains = []
    @@all_stations << self    
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
