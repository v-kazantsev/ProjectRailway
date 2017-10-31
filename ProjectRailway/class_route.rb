require_relative 'class_station'
require_relative 'module'

class Route

  include Valide

  attr_reader :stations
  attr_accessor :route_choice

  NAME_FORMAT = /^\w+/
  @@all_routes = []

  def initialize(start,finish)
    @start = start
    @finish = finish
    return unless validate!
    @stations = []
    @start = self.find_station_by_name(@start)
    @finish = self.find_station_by_name(@finish)
    @stations << @start
    @stations << @finish
    @@all_routes << @stations
    @@all_routes.uniq!
    puts "МАРШРУТ \"#{start}\" - \"#{finish}\" СОЗДАН"
  end

  def self.all_routes
    @@all_routes
  end

  def find_station_by_name(station_name)
    @find_station_by_name = Station.all.detect { |x| x.name == station_name }
  end

  
  def add_station
    puts 'ВЫБЕРИТЕ МАРШРУТ'
    @@all_routes.map.with_index do |e,i| 
      print "[#{i+1}] "
      e.map {|x| print "#{x.name} " }
      print "\n"
    end
    current_route_index = gets.to_i
    puts 'ВВЕДИТЕ НАЗВАНИЕ СТАНЦИИ'
    station_name = gets.chomp.downcase  
    @station = find_station_by_name(station_name)
    @@all_routes[current_route_index-1].insert(-2, @station)
    puts "СТАНЦИЯ #{@station} ДОБАВЛЕНА"
  end

  def remove_station
    puts 'ВЫБЕРИТЕ МАРШРУТ'
    @@all_routes.map.with_index do |e,i| 
      print "[#{i+1}] "
      e.map {|x| print "#{x.name} " }
      print "\n"
    end
    current_route_index = gets.to_i
    puts 'ВВЕДИТЕ НАЗВАНИЕ СТАНЦИИ'
    station_name = gets.chomp.downcase  
    @station = find_station_by_name(station_name)
    @@all_routes[current_route_index-1].delete(@station)
    puts "СТАНЦИЯ #{@station} УБРАНА"
  end

  def routes_info
    puts '----------'
    Route.all_routes.map { |e| puts e.map {|i| print "#{i.name} "} }
    puts '----------' 
  end

  private

  def validate!
    raise 'НЕВЕРНЫЙ ФОРМАТ ИМЕНИ' unless NAME_FORMAT.match(@start) && NAME_FORMAT.match(@finish)
    raise 'НЕТ ТАКОЙ СТАНЦИИ' if find_station_by_name(@start).nil? || find_station_by_name(@finish).nil?
    true
  rescue => e 
    puts "#{e.message}"
    false
  end
end

