class Station
  require_relative "class_train"

  attr_accessor :trains 

  def initialize(name)       #создает станцию с заданным в аргументе именем
    @name = name
    @trains = []    
  end

  def train_in(train)       #принимает поезд (объект класса Поезд)
    self.trains << train          
  end

  def train_out(train)     
    trains.delete(train)     
  end

  def train_type_list(type)             
    cargo_trains = trains.count { |t| t.type == :cargo }
    passenger_trains = trains.count { |t| t.type == :passenger }
    return cargo_trains, passenger_trains
  end

end
