class Station
  def initialize(name)       #создает станцию с заданным в аргументе именем
    @name = name
    @trains_currently_in = 0 #поездов на станции нет
    @train_list = []        
    @train_type_list = {passenger: 0, cargo: 0} 
  end
  attr_accessor :trains_currently_in
  def train_in(train, type) #принимает поезд, добавляет его название в список поездов,
    train_name = train      #увеличивает на единицу количество грузовых или пассажирских поездов
    train_type = type       #и увеличивает счетчик количества поездов на единицу
    @train_list << train_name
    @train_type_list[train_type] +=1
    self.trains_currently_in += 1
  end
  def train_out(train, type) #отправляет поезд, удаляет его название из списка,
    train_name = train       #уменьшает количество грузовых или пассажирских поездов  
    train_type = type        #и уменьшает счетчик поездов на единицу
    @train_list.delete(train_name)
    @train_type_list[train_type] -= 1
    self.trains_currently_in -= 1 
  end
  def train_list             #выводит поименный список находящихся на станции поездов
    puts @train_list
  end
  def train_type_list        #выводит количество находящихся на станции грузовых или       
    puts self.trains_currently_in == 0? "Сейчас поездов нет" : #пассажирских поездов
    "Сейчас поездов на станции: #{@train_type_list}"   
  end
end
