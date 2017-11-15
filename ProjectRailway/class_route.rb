require_relative 'class_station'
require_relative 'module_validation'

class Route
  include Validation
  attr_reader :stations
  attr_accessor :start, :finish
  validate :start, :type, Station
  validate :finish, :type, Station

  def initialize(start, finish)
    @start = start
    @finish = finish
    raise RuntimeError, 'Start and finish must be different' if @start.name == @finish.name
    @stations = [start, finish]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station)
  end
end
