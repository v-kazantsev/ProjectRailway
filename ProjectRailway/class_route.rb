class Route
  require_relative "class_station"
  
  attr_reader :stations

  def initialize(start,finish)
    @stations = [start,finish]
  end

  def add_station(station)          
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station)
  end
end

