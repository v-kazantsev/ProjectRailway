class Train
  require_relative "class_route"

  attr_reader :current_route

  def initialize (number, type, qtty)
    @number = number                        #номер поезда
    @type = type                            #тип поезда
    @qtty = qtty                            #количество вагонов
    @speed = 0                              #поезд стоит
    @current_station_index = 0              #индекс текущей станции
  end

  def take_route(route)   #передаем объект класса Маршрут
    self.current_route = route  
    self.current_station.train_in(self)
  end

  def speed_up
    @speed += 50
  end

  def stop
    @speed = 0
  end

  def current_station                  #возвращает текущую станцию
    current_route.stations[current_station_index]
  end

  def move_forward
    unless self.current_station == current_route.stations[-1]
      self.current_station.train_out(self)
      self.speed_up
      self.stop
      current_station_index += 1
      self.current_station.train_in(self)
    end
  end

  def move_back
    unless self.current_station == current_route.stations[0]
      self.current_station.train_out(self)
      self.speed_up
      self.stop
      current_station_index -= 1
      self.current_station.train_in(self)
    end
  end

  def report_previous
    @previous_station = current_route.stations[current_station_index-1]
  end

  def report_next
    @next_station = current_route.stations[current_station_index+1]
  end

end



  
  