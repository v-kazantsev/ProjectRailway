class Train
  require_relative "class_route"

  attr_accessor :hop, :current_route

  def initialize (number, type, qtty)
    @number = number      #номер поезда
    @type = type          #тип поезда
    @qtty = qtty          #количество вагонов
    @speed = 0            #поезд стоит
    @hop = 0              #индекс текущей станции
  end

  def take_route(route)   #передаем объект класса Маршрут
    self.current_route = route 
  end

  def speed_up
    @speed += 50
  end

  def stop
    @speed = 0
  end

  def c_s                  #возвращает текущую станцию
    @current_station = current_route.stations[hop]
  end

  def move_forward
    self.c_s 
    unless @current_station == current_route.stations[-1]
      @current_station.train_out(self)
      self.speed_up
      self.stop
      self.hop += 1
      @current_station.train_in(self)
    end
  end

  def move_back
    self.c_s 
    unless @current_station == @current_route.stations[0]
      @current_station.train_out(self)
      self.speed_up
      self.stop
      self.hop -= 1
      @current_station.train_in(self)
    end
  end

  def report_nearest
    self.c_s 
    @previous_station = @current_route.stations[hop-1]
    @next_station = @current_route.stations[hop+1]
    return @previous_station, @current_station, @next_station
  end

end



  
  