require_relative 'class_route'
require_relative 'class_wagon'
require_relative 'module'

class Train

  include Maker
  
  attr_accessor :current_route, :current_station_index, :wagons
  attr_reader   :number

  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-*[a-zа-я0-9]{2}$/i 
  @@all_trains = {}

  def initialize (number)
    @number = number
    validate!           
    @wagons = []                            
    @speed = 0
    @current_route = []                              
    @current_station_index = 0
    @@all_trains[number] = self     
  end

  def self.all 
    @@all_trains
  end

  def self.find(train_number)
    @@all_trains[train_number] 
  end

  def current_station                  
    current_route.stations[current_station_index]
  end

  def take_route(route)   
    self.current_route = route  
    current_station.train_in(self)  
  end

  def add_wagon(wagon)
    self.wagons << wagon  if @speed.zero? 
  end

  def remove_wagon(wagon_number)
    self.wagons.delete_at(wagon_number) if @speed.zero?  
    self.wagons.compact! 
  end

  def move_forward
    unless current_station == current_route.stations[-1]
      current_station.train_out(self)
      speed_up
      stop
      self.current_station_index += 1
      current_station.train_in(self)
    end
  end

  def move_back
    unless current_station == current_route.stations[0]
      current_station.train_out(self)
      speed_up
      stop
      self.current_station_index -= 1
      current_station.train_in(self)
    end
  end

  def all_wagons(train_number,wagons_block)
    for i in 0..train_number.wagons.size-1
      wagons_block.call(i, train_number.wagons[i])
    end
  end

protected #ТОЛЬКО ЭТИ МЕТОДЫ ВЫЗЫВАЮТСЯ ВНУТРИ СУБКЛАССОВ
          #ВСЕ ОСТАЛЬНЫЕ МЕТОДЫ ВЫЗЫВАЮТСЯ ИЗВНЕ МЕТОДА TRAIN И ЕГО СУБКЛАССОВ
  
  def speed_up
    @speed += 50
  end

  def stop
    @speed = 0
  end

  def report_previous
    current_route.stations[current_station_index-1]
  end

  def report_next
    current_route.stations[current_station_index+1]
  end

  private 

  def validate!
    raise RuntimeError.new('НЕПРАВИЛЬНЫЙ ФОРМАТ НОМЕРА') unless NUMBER_FORMAT.match(number)
  end

  def valid?
    validate!
    true
    rescue => e
    puts "#{e.message}"
    false
  end
end







  
  