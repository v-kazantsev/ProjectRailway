require_relative 'class_train'
require_relative 'class_station'
require_relative 'class_route'
require_relative 'class_cargo_train'
require_relative 'class_passenger_train'
require_relative 'module'

class Menu

  include Valide

  def create_train
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    train_number = gets.chomp.downcase
    puts 'ВВЕДИТЕ ТИП ПОЕЗДА'
    puts '[1] ГРУЗОВОЙ'
    puts '[2] ПАССАЖИРСКИЙ'
    @choice = gets.chomp
    return unless validate!
    @train_type = @choice
    if @train_type == '1'
      @train = CargoTrain.new(train_number)
    elsif @train_type == '2'
      @train = PassengerTrain.new(train_number)
    end
    puts 'НАЗНАЧИТЬ ПОЕЗДУ МАРШРУТ?'
    puts '[1] ДА'
    puts '[2] НЕТ'
    @choice = gets.chomp
    return unless validate!
    if @choice == '1' && Station.all.size > 1
      assign_route
    elsif @choice == '1'
      2.times {create_station}
      create_route
      assign_route
    end
  end

  def create_station
    puts 'ВВЕДИТЕ НАЗВАНИЕ СТАНЦИИ'
    station_name = gets.chomp.downcase
    @station = Station.new(station_name)
  end
  def create_route
    puts 'ВВЕДИТЕ НАЗВАНИЕ НАЧАЛЬНОЙ СТАНЦИИ'
    start = gets.chomp.downcase
    puts 'ВВЕДИТЕ НАЗВАНИЕ КОНЕЧНОЙ СТАНЦИИ'
    finish = gets.chomp.downcase
    @route = Route.new(start,finish)
  end
  def assign_route
    @train.assign_route
  end
  def add_wagons
    @train.add_wagon
  end
  def remove_wagons
    @train.remove_wagon
  end
  def add_station
    @route.add_station
  end
  def remove_station
    @route.remove_station
  end
  def move_forward
    @train.move_forward
  end
  def move_back
    @train.move_back
  end
  def stations_info
    @station.stations_info
  end
  def trains_info
    @train.trains_info
  end
  def routes_info
    @route.routes_info
  end

  private
  def validate!
    raise 'ВЫБЕРИТЕ 1 ИЛИ 2' if @choice !~ /[12]/
    true 
  rescue => e
    puts "#{e.message}"
    false
  end
end