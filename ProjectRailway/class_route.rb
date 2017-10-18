class Route
  require_relative "class_station"
  
  attr_accessor :stations

  def initialize(start,finish)
    @stations = [start,finish]
  end

  def add_station(station)           #передаем объект Станция
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end
end

