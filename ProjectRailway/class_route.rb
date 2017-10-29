require_relative "class_station"
require_relative "module"
class Route
  attr_reader :stations
  include Valide
  def validate!
    raise 'Неверно заданы пункты маршрута' if stations.size < 2
    true
  end


  def initialize(start,finish)
    @stations = [start,finish]
    validate!
  end

  def add_station(station)          
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end
end

