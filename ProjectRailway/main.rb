require_relative 'class_station' 
require_relative 'class_train'
require_relative 'class_route'
require_relative 'class_cargo_train'
require_relative 'class_passenger_train'
require_relative 'class_wagon'


@all_stations = []
def all_stations=(all_stations)
  @all_stations = all_stations
end
def all_stations
  @all_stations
end

@all_trains = []
def all_trains=(all_trains)
  @all_trains = all_trains
end
def all_trains
  @all_trains
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

  puts "ВВЕДИТЕ ИМЯ СТАНЦИИ"
  station_name = gets.chomp.upcase
  station = Station.new(station_name)
  all_stations << station 
  puts "СТАНЦИЯ #{station_name} СОЗДАНА"

  when "2" 

  puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
  train_number = gets.chomp
  puts "ВВЕДИТЕ ТИП ПОЕЗДА"
  puts "[1] ГРУЗОВОЙ"
  puts "[2] ПАССАЖИРСКИЙ"
  train_type = gets.chomp
  if train_type == "1" 
    train = CargoTrain.new(train_number)
    all_trains << train 
    puts "СОЗДАН ГРУЗОВОЙ ПОЕЗД #{train_number}"
  else
    puts "СОЗДАН ПАССАЖИРСКИЙ ПОЕЗД #{train_number}"
    train = PassengerTrain.new(train_number)
    all_trains << train 
  end

  when "3" 

  puts "ВВЕДИТЕ НАЧАЛЬНУЮ СТАНЦИЮ МАРШРУТА"
  start = gets.chomp.upcase
  from = all_stations.detect { |x| x.name == start }
  puts "ВВЕДИТЕ КОНЕЧНУЮ СТАНЦИЮ МАРШРУТА"
  finish =  gets.chomp.upcase
  to = all_stations.detect { |x| x.name == finish }
  route = Route.new(from,to)
  puts "МАРШРУТ #{start} - #{finish} СОЗДАН"

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
      puts "ВВЕДИТЕ ИМЯ СТАНЦИИ"
      station_name = gets.chomp.upcase
      find_station = all_stations.detect { |x| x.name == station_name }
      route.add_station(find_station)
      puts "СТАНЦИЯ #{station_name} ДОБАВЛЕНА"

      when "2"
      puts "ВВЕДИТЕ ИМЯ СТАНЦИИ"
      station_name = gets.chomp.upcase
      find_station = all_stations.detect { |x| x.name == station_name }
      route.remove_station(find_station)
      puts "СТАНЦИЯ #{station_name} УБРАНА"

      when "3"
      puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
      train_number = gets.chomp
      find_train = all_trains.detect{ |x| x.number == train.number }
      find_train.take_route(route)
      route_assigned = true
      puts "МАРШРУТ НАЗНАЧЕН"
      
      when "4"
      puts "[1] ДОБАВИТЬ ГРУЗОВОЙ ВАГОН"
      puts "[2] ДОБАВИТЬ ПАССАЖИРСКИЙ ВАГОН"
      choice2 = gets.chomp
      if choice2 == "1"
        wagon = Wagon.new(:cargo)
        train.add_wagon(wagon)
        puts "ГРУЗОВОЙ ВАГОН ДОБАВЛЕН"
      elsif choice2 == "2"
        wagon = Wagon.new(:passenger)
        train.add_wagon(wagon)
      end  
      when "5"
      train.remove_wagon(wagon)
      when "6"
      puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
      train_number = gets.chomp
      find_train = all_trains.detect{ |x| x.number == train.number }
      find_train.move_forward
      when "7"
      puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
      train_number = gets.chomp
      find_train = all_trains.detect{ |x| x.number == train.number }
      find_train.move_back
      when "8"
      puts "ВВЕДИТЕ НОМЕР ПОЕЗДА"
      train_number = gets.chomp
      find_train = all_trains.detect{ |x| x.number == train.number }
      unless route_assigned
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
      when "9"
      @all_stations.detect { |x| puts "#{x.name} ПАССАЖИРСКИХ ПОЕЗДОВ #{x.train_type_list(:passenger)}
      ГРУЗОВЫХ ПОЕЗДОВ #{x.train_type_list(:cargo)}" }
  end
end
end





