require_relative 'class_station'
require_relative 'module'

class Route

  attr_reader :stations
  
  def initialize(start,finish)
    @stations = [start,finish]
  end

  def add_station(station)          
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end
end

