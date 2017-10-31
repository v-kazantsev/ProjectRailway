require_relative 'class_train'
require_relative 'class_station'
require_relative 'class_route'
require_relative 'module'

class Menu

  include Valide
  
  attr_reader :train_number,  :station_name
  attr_accessor :all_stations

  def initialize
   @all_stations = []
  end

  def create_station
    puts "ВВЕДИТЕ ИМЯ СТАНЦИИ"
    @station_name = gets.chomp.upcase
    @station = Station.new(station_name) 
    @all_stations << @station
    puts "СТАНЦИЯ #{station_name} СОЗДАНА"
  end

  def create_train
    puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
    @train_number = gets.chomp
    puts "ВВЕДИТЕ ТИП ПОЕЗДА"
    puts "[1] ГРУЗОВОЙ"
    puts "[2] ПАССАЖИРСКИЙ"
    train_type = gets.chomp
    if train_type == "1" 
      @train = CargoTrain.new(train_number)
      @route_assigned = false
    elsif train_type == "2"
      @train = PassengerTrain.new(train_number)
      @route_assigned = false
    end
  end

  def get_station_by_name(str)
    @all_stations.detect { |x| x.name == str }
  end
    
  def create_route
    puts "ВВЕДИТЕ НАЧАЛЬНУЮ СТАНЦИЮ МАРШРУТА"
    start = gets.chomp.upcase
    from = get_station_by_name(start)
    puts "ВВЕДИТЕ КОНЕЧНУЮ СТАНЦИЮ МАРШРУТА"
    finish =  gets.chomp.upcase
    to = get_station_by_name(finish)
    @route = Route.new(from,to)
    @route_created = true 
    puts "МАРШРУТ #{start} - #{finish} СОЗДАН"
  end

  def add_station_to_route
    if @route_created
      puts "ВВЕДИТЕ ИМЯ СТАНЦИИ"
      @station_name = gets.chomp.upcase
      find_station = get_station_by_name(station_name)
      @route.add_station(find_station)
      puts "СТАНЦИЯ #{station_name} ДОБАВЛЕНА"
    else
      puts "МАРШРУТ ЕЩЕ НЕ СОЗДАН"
    end
  end

  def remove_station_from_route
    puts "ВВЕДИТЕ ИМЯ СТАНЦИИ"
    @station_name = gets.chomp.upcase
    find_station = get_station_by_name(station_name)
    @route.remove_station(find_station)
    puts "СТАНЦИЯ #{station_name} УБРАНА"
  end

  def assign_route
    if @route_created
      puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
      train_number = gets.chomp
      find_train = Train.find(train_number)
      find_train.take_route(@route)
      @route_assigned = true
      puts "МАРШРУТ НАЗНАЧЕН"
    else 
      puts "МАРШРУТ ЕЩЕ НЕ СОЗДАН"
    end
  end

  def add_wagon_by_type
    puts "[1] ДОБАВИТЬ ГРУЗОВОЙ ВАГОН"
    puts "[2] ДОБАВИТЬ ПАССАЖИРСКИЙ ВАГОН"
    choice = gets.chomp
    if choice == "1"
      @wagon = Wagon.new(:cargo)
      @train.add_wagon(@wagon)
      puts "ГРУЗОВОЙ ВАГОН ДОБАВЛЕН"
    elsif choice == "2"
      @wagon = Wagon.new(:passenger)
      @train.add_wagon(@wagon)
    end  
  end

  def remove_wagon
    @train.remove_wagon(@wagon)
  end

  def move_train_forward
    puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
    train_number = gets.chomp
    find_train = Train.find(train_number)
    find_train.move_forward
  end

  def move_train_back
    puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
    train_number = gets.chomp
    find_train = Train.find(train_number)
    find_train.move_back
  end

  def put_trains_info
    puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
    train_number = gets.chomp
    find_train = Train.find(train_number)
    unless @route_assigned
      puts "СНАЧАЛА НАДО НАЗНАЧИТЬ МАРШРУТ"
    else
      if find_train.type == :cargo
        current_train_type = "ГРУЗОВОЙ"
        elsif find_train.type == :passenger 
        current_train_type = "ПАССАЖИРСКИЙ"
      end
    puts current_train_type + " ПОЕЗД #{train_number} НАХОДИТСЯ НА СТАНЦИИ #{find_train.current_station.name}
    И СОСТОИТ ИЗ #{find_train.wagons.size} ВАГОНОВ"
    end
  end

  def put_stations_info
    @all_stations.detect { |x| puts "#{x.name} ПАССАЖИРСКИХ ПОЕЗДОВ #{x.train_type_list(:passenger)}
    ГРУЗОВЫХ ПОЕЗДОВ #{x.train_type_list(:cargo)}" }
  end

end






