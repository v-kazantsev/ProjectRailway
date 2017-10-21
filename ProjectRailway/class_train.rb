class Train
  require_relative "class_route"
  require_relative "class_wagon"

  attr_accessor :current_route, :current_station_index
  attr_reader   :number, :wagons


  def initialize (number)
    @number = number                           
    @wagons = []                            
    @speed = 0
    @current_route = []                              
    @current_station_index = 0            
  end

  def current_station                  #возвращает текущую станцию
    current_route.stations[current_station_index]
  end

  def take_route(route)   
    self.current_route = route  
    current_station.train_in(self)  
  end

  def add_wagon(wagon)
    @wagons << wagon  if @speed.zero? && self.type == wagon.type 
  end

  def remove_wagon(wagon)
    @wagons.delete_at(0) if @speed.zero? && !wagons.empty?    
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

end







  
  