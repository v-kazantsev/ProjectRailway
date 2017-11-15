require_relative 'class_train'
require_relative 'class_station'
require_relative 'class_route'
require_relative 'module'
require_relative 'class_cargo_wagon'
require_relative 'class_passenger_wagon'
require_relative 'module_validation'

class Menu
  include Validation
  attr_reader :train_number, :station_name
  attr_accessor :all_stations

  def initialize
    @all_stations = []
  end

  def create_station
    puts 'ВВЕДИТЕ ИМЯ СТАНЦИИ'
    @station_name = gets.chomp.upcase
    if Station.new(station_name).valid?
      @station = Station.new(station_name) 
    else
      return
    end
    @all_stations << @station
    puts "СТАНЦИЯ #{station_name} СОЗДАНА"
  end

  def create_train
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    @train_number = gets.chomp
    puts 'ВВЕДИТЕ ТИП ПОЕЗДА'
    puts '[1] ГРУЗОВОЙ'
    puts '[2] ПАССАЖИРСКИЙ'
    train_type = gets.chomp
    if train_type == '1'
      create_cargo_train
    elsif train_type == '2'
      create_passenger_train
    end
  end

  def create_cargo_train
    if Train.new(train_number).valid?
      @train = CargoTrain.new(train_number)
    else
      return
    end
    train_created = true
    puts "ГРУЗОВОЙ ПОЕЗД #{train_number} СОЗДАН" if train_created
    @route_assigned = false
  end

  def create_passenger_train
    if Train.new(train_number).valid?
      @train = PassengerTrain.new(train_number)
    else
      return
    end
    train_created = true
    puts "ПАССАЖИРСКИЙ ПОЕЗД #{train_number} СОЗДАН" if train_created
    @route_assigned = false
  end

  def get_station_by_name(str)
    @all_stations.detect { |x| x.name == str }
  end

  def create_route
    puts 'ВВЕДИТЕ НАЧАЛЬНУЮ СТАНЦИЮ МАРШРУТА'
    start = gets.chomp.upcase
    from = get_station_by_name(start)
    puts 'ВВЕДИТЕ КОНЕЧНУЮ СТАНЦИЮ МАРШРУТА'
    finish = gets.chomp.upcase
    to = get_station_by_name(finish)
    if Route.new(from,to).valid?
      @route = Route.new(from, to)
    else
      return
    end
    @route_created = true
    puts "МАРШРУТ #{start} - #{finish} СОЗДАН"
  end

  def add_station_to_route
    if @route_created
      puts 'ВВЕДИТЕ ИМЯ СТАНЦИИ'
      @station_name = gets.chomp.upcase
      find_station = get_station_by_name(station_name)
      @route.add_station(find_station)
      puts "СТАНЦИЯ #{station_name} ДОБАВЛЕНА"
    else
      puts 'МАРШРУТ ЕЩЕ НЕ СОЗДАН'
    end
  end

  def remove_station_from_route
    puts 'ВВЕДИТЕ ИМЯ СТАНЦИИ'
    @station_name = gets.chomp.upcase
    find_station = get_station_by_name(station_name)
    @route.remove_station(find_station)
    puts "СТАНЦИЯ #{station_name} УБРАНА"
  end

  def assign_route
    if @route_created
      puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
      train_number = gets.chomp
      find_train = Train.find(train_number)
      find_train.take_route(@route)
      @route_assigned = true
      puts 'МАРШРУТ НАЗНАЧЕН'
    else
      puts 'МАРШРУТ ЕЩЕ НЕ СОЗДАН'
    end
  end

  def add_wagon_by_type
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    train_number = gets.chomp
    find_train = Train.find(train_number)
    if find_train.type == :cargo
      puts 'ВВЕДИТЕ ОБЪЕМ ВАГОНА'
      volume = gets.to_i
      @wagon = CargoWagon.new(:cargo, volume)
      @train.add_wagon(@wagon)
      puts 'ГРУЗОВОЙ ВАГОН ДОБАВЛЕН'
    elsif find_train.type == :passenger
      puts 'ВВЕДИТЕ КОЛИЧЕСТВО МЕСТ'
      seats = gets.to_i
      @wagon = PassengerWagon.new(:passenger, seats)
      @train.add_wagon(@wagon)
      puts 'ПАССАЖИРСКИЙ ВАГОН ДОБАВЛЕН'
    end
  end

  def remove_wagon
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    train_number = gets.chomp
    find_train = Train.find(train_number)
    puts 'ВВЕДИТЕ НОМЕР ВАГОНА'
    wagon_number = gets.to_i - 1
    find_train.remove_wagon(wagon_number)
  end

  def move_train_forward
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    train_number = gets.chomp
    find_train = Train.find(train_number)
    find_train.move_forward
  end

  def move_train_back
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    train_number = gets.chomp
    find_train = Train.find(train_number)
    find_train.move_back
  end

  def load_wagon
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    train_number = gets.chomp
    find_train = Train.find(train_number)
    puts 'ВВЕДИТЕ НОМЕР ВАГОНА'
    wagon_number = gets.to_i - 1
    if find_train.wagons[wagon_number].nil? || wagon_number < 0
      puts 'ВАГОН ЕЩЕ НЕ СОЗДАН'
    elsif find_train.type == :cargo
      puts 'ВВЕДИТЕ ОБЪЕМ'
      volume = gets.to_i
      find_train.wagons[wagon_number].load(volume)
      puts "ЗАНЯТ ОБЪЕМ #{volume}"
    elsif find_train.type == :passenger
      find_train.wagons[wagon_number].take_seat
      puts 'ЗАНЯТО ОДНО МЕСТО'
    end
  end

  def put_trains_info
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    train_number = gets.chomp
    find_train = Train.find(train_number)
    if @route_assigned
      if find_train.type == :cargo
        current_train_type = 'ГРУЗОВОЙ'
      elsif find_train.type == :passenger
        current_train_type = 'ПАССАЖИРСКИЙ'
      end
      puts current_train_type + " ПОЕЗД #{train_number} НАХОДИТСЯ НА СТАНЦИИ
      #{find_train.current_station.name} И СОСТОИТ ИЗ #{find_train.wagons.size}
      ВАГОНОВ"
    else
      puts 'СНАЧАЛА НАДО НАЗНАЧИТЬ МАРШРУТ'
    end
  end

  def put_stations_info
    @all_stations.detect do |x|
      puts "#{x.name} ПАССАЖИРСКИХ ПОЕЗДОВ #{x.train_type_list(:passenger)}
    ГРУЗОВЫХ ПОЕЗДОВ #{x.train_type_list(:cargo)}"
    end
  end

  def show_trains
    trains_block = proc do |t|
      puts "ПОЕЗД № #{t.number}  ТИП #{t.type}  СОСТОИТ ИЗ #{t.wagons.size}
      ВАГОНОВ"
    end
    Station.all.each do |k, s|
      puts "СТАНЦИЯ #{k}:"
      s.all_trains(&trains_block)
    end
  end

  def show_wagons
    wagons_block = proc do |w, i|
      if w.type == :cargo
        puts "ВАГОН № #{i + 1} ТИП #{w.type} ЗАНЯТО #{w.volume_taken} СВОБОДНО
        #{w.volume - w.volume_taken}"
      elsif w.type == :passenger
        puts "ВАГОН № #{i + 1} ТИП #{w.type} ЗАНЯТО #{w.seats_taken} СВОБОДНО
        #{w.seats - w.seats_taken}"
      end
    end
    Train.all.each do |k, t|
      puts "ПОЕЗД № #{k}:"
      t.all_wagons(&wagons_block)
    end
  end
end
