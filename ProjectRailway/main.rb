require_relative 'class_station' 
require_relative 'class_train'
require_relative 'class_route'
require_relative 'class_cargo_train'
require_relative 'class_passenger_train'
require_relative 'class_wagon'


@all_stations = []
@all_trains = []

def create_station
  puts "ВВЕДИТЕ ИМЯ СТАНЦИИ"
  station_name = gets.chomp.upcase
  @station = Station.new(station_name)
  @all_stations << @station 
  puts "СТАНЦИЯ #{station_name} СОЗДАНА"
end

def create_train
  puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
  train_number = gets.chomp
  puts "ВВЕДИТЕ ТИП ПОЕЗДА"
  puts "[1] ГРУЗОВОЙ"
  puts "[2] ПАССАЖИРСКИЙ"
  train_type = gets.chomp
  if train_type == "1" 
    @train = CargoTrain.new(train_number)
    @all_trains << @train 
    @route_assigned = false
    puts "СОЗДАН ГРУЗОВОЙ ПОЕЗД #{train_number}"
  else
    puts "СОЗДАН ПАССАЖИРСКИЙ ПОЕЗД #{train_number}"
    @train = PassengerTrain.new(train_number)
    @all_trains << @train 
    @route_assigned = false
  end
end

def create_route
  puts "ВВЕДИТЕ НАЧАЛЬНУЮ СТАНЦИЮ МАРШРУТА"
  start = gets.chomp.upcase
  from = @all_stations.detect { |x| x.name == start }
  puts "ВВЕДИТЕ КОНЕЧНУЮ СТАНЦИЮ МАРШРУТА"
  finish =  gets.chomp.upcase
  to = @all_stations.detect { |x| x.name == finish }
  @route = Route.new(from,to)
  @route_created = true 
  puts "МАРШРУТ #{start} - #{finish} СОЗДАН"
end

def add_station_to_route
  if @route_created
  puts "ВВЕДИТЕ ИМЯ СТАНЦИИ"
  station_name = gets.chomp.upcase
  find_station = @all_stations.detect { |x| x.name == station_name }
  @route.add_station(find_station)
  puts "СТАНЦИЯ #{station_name} ДОБАВЛЕНА"
  else
    puts "МАРШРУТ ЕЩЕ НЕ СОЗДАН"
  end
end

def remove_station_from_route
  puts "ВВЕДИТЕ ИМЯ СТАНЦИИ"
  station_name = gets.chomp.upcase
  find_station = @all_stations.detect { |x| x.name == station_name }
  @route.remove_station(find_station)
  puts "СТАНЦИЯ #{station_name} УБРАНА"
end

def assign_route
  if @route_created
  puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
  train_number = gets.chomp
  find_train = @all_trains.detect{ |x| x.number == train_number }
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
  choice2 = gets.chomp
  if choice2 == "1"
  @wagon = Wagon.new(:cargo)
  @train.add_wagon(@wagon)
  puts "ГРУЗОВОЙ ВАГОН ДОБАВЛЕН"
    elsif choice2 == "2"
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
  find_train = @all_trains.detect{ |x| x.number == train_number }
  find_train.move_forward
end

def move_train_back
  puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
  train_number = gets.chomp
  find_train = @all_trains.detect{ |x| x.number == train_number }
  find_train.move_back
end

def put_trains_info
  puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
  train_number = gets.chomp
  find_train = @all_trains.detect{ |x| x.number == train_number }
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

choice = "0"
until choice == "5" do

puts "ВЫБЕРИТЕ ДЕЙСТВИЕ:"
puts "[1] СОЗДАТЬ СТАНЦИЮ"
puts "[2] СОЗДАТЬ ПОЕЗД"
puts "[3] СОЗДАТЬ МАРШРУТ"
puts "[4] УПРАВЛЯТЬ СОЗДАННЫМИ ОБЪЕКТАМИ"
puts "[5] ВЫХОД"
choice = gets.chomp

case choice
  when "1"

  create_station
  
  when "2" 

  create_train

  when "3" 

  create_route

  when "4"

    puts "[1] ДОБАВИТЬ СТАНЦИЮ В  МАРШРУТ"
    puts "[2] УБРАТЬ СТАНЦИЮ ИЗ МАРШРУТА"
    puts "[3] НАЗНАЧИТЬ МАРШРУТ ПОЕЗДУ"
    puts "[4] ДОБАВИТЬ ВАГОНЫ"
    puts "[5] УБРАТЬ ВАГОНЫ"
    puts "[6] ПЕРЕМЕСТИТЬ ПОЕЗД ВПЕРЕД"
    puts "[7] ПЕРЕМЕСТИТЬ ПОЕЗД НАЗАД"
    puts "[8] ВЫВЕСТИ ИНФОРМАЦИЮ О ПОЕЗДАХ"
    puts "[9] ВЫВЕСТИ ИНФОРМАЦИЮ О СТАНЦИЯХ"

    choice1 = gets.chomp

    case choice1
      when "1"

      add_station_to_route

      when "2"
      
      remove_station_from_route

      when "3"

      assign_route
      
      when "4"

      add_wagon_by_type
      
      when "5"
      
      remove_wagon

      when "6"

      move_train_forward
      
      when "7"

      move_train_back
      
      when "8"

      put_trains_info
      
      when "9"

      put_stations_info
      
  end
end
end





