require_relative 'class_station'
require_relative 'module'

class Route
  attr_reader :stations
  attr_accessor :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
    validate!
    @stations = [start, finish]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station)
  end

  private

  def validate!
    raise 'ОШИБКА АРГУМЕНТА!' unless start.is_a?(Station) ||
                                     finish.is_a?(Station)
    raise 'НАЧАЛЬНАЯ И КОНЕЧНАЯ СТАНЦИИ МАРШРУТА ДОЛЖНЫ БЫТЬ РАЗНЫМИ'
    if start == finish
    end
  end

  def valid?
    validate!
    true
  rescue RuntimeError => e
    puts e.message.to_s
    false
  end
end
