class Station
  require_relative "class_train"

  attr_accessor :train_list

  def initialize(name)       #создает станцию с заданным в аргументе именем
    @name = name
    @train_list = [] 
    @cargo_train = 0
    @passenger_train = 0    
  end

  def train_in(train)       #принимает поезд (объект класса Поезд)
    self.train_list << train          
  end

  def train_out(train)     
    train_list.delete(train)     
  end

  def train_type_list(type)             
    train_list.each do |t|
      if t.type == :cargo
      @cargo_train += 1 
      else @passenger_train += 1 
      end
    end
  end

end
