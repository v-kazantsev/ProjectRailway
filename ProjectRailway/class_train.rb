require_relative 'class_route'
require_relative 'class_wagon'
require_relative 'module'

class Train
  include Maker
  include Valide

  attr_reader :current_route, :number 
  attr_accessor :current_station_index, :wagons, :route_assigned
  
  @@all_trains = {}
  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-*[a-zа-я0-9]{2}$/i 
  
  def initialize (number)
    @number = number
    return unless validate!
    @speed = 0
    @wagons = []
    @route_assigned = false
    @current_route = []
    @@all_trains[number] = self   
    puts "ПОЕЗД НОМЕР #{@number} СОЗДАН"      
  end

  def current_station
    current_route[current_station_index]
  end

  def assign_route
    #puts "НЕ СОЗДАНО НИ ОДНОГО МАРШРУТА" unless @route_created
    puts 'ВЫБЕРИТЕ МАРШРУТ'
    Route.all_routes.each_with_index do  |x,i|
      print "[#{i+1}]: " 
      x.map {|n| print "#{n.name} " }
      print "\n"
    end  #выводим список всех созданных маршрутов
    current_route_index = gets.to_i
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА' 
    number = gets.chomp.downcase 
    return unless validate!
    current_train = @@all_trains[number]
    current_train.current_route.replace(Route.all_routes[current_route_index-1]) #выбранный маршрут делаем атрибутом поезда
    current_train.current_station_index = 0 
    current_train.current_station.train_in(current_train)
    current_train.route_assigned = true
    puts "МАРШРУТ НАЗНАЧЕН"
  end

  def move_forward
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА' 
    number = gets.chomp.downcase 
    return unless validate!
    current_train = @@all_trains[number]
    unless current_train.current_station == current_train.current_route.stations[-1]
      current_train.current_station.train_out(current_train)
      speed_up
      stop
      current_train.current_station_index += 1
      current_train.current_station.train_in(current_train)
      puts "ПОЕЗД #{current_train.number} ПЕРЕМЕЩЕН НА СТАНЦИЮ #{current_station.name}"
    end
  end

  def move_back
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    number = gets.chomp.downcase
    return unless validate!
    current_train = @@all_trains[number]
    unless current_train.current_station == current_train.current_route.stations[0]
      current_train.current_station.train_out(current_train)
      speed_up
      stop
      current_train.current_station_index -= 1
      current_train.current_station.train_in(current_train)
      puts "ПОЕЗД #{current_train.number} ПЕРЕМЕЩЕН НА СТАНЦИЮ #{current_station.name}"
    end
  end


  def add_wagon
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    number = gets.chomp.downcase
    return unless validate!
    current_train = self.class.find(number)
    if current_train.type == :cargo
      wagon = Wagon.new(:cargo)
    else
      wagon = Wagon.new(:passenger)
    end
    current_train.wagons << wagon
    puts 'ВАГОН ДОБАВЛЕН'
  end

  def remove_wagon
    puts 'ВВЕДИТЕ НОМЕР ПОЕЗДА'
    number = gets.chomp.downcase
    return unless validate!
    current_train = self.class.find(number)
    if @speed.zero? && !current_train.wagons.empty? 
      current_train.wagons.delete_at(0) 
      puts 'ВАГОН УДАЛЕН'
    else
      puts 'НЕВОЗМОЖНО УДАЛИТЬ ВАГОН'
    end
  end

  def trains_info
    puts '----------'
    Train.all_trains.each { |k,v| puts "ПОЕЗД [#{k}] ИЗ #{v.wagons.size} ВАГОНОВ НАХОДИТСЯ НА СТАНЦИИ #{v.current_station.name}
    И СЛЕДУЕТ ПО МАРШРУТУ #{v.current_route[0].name} - #{v.current_route[-1].name}" } 
    puts '----------'
  end

  def self.all_trains
    @@all_trains
  end

  protected #ТОЛЬКО ЭТИ МЕТОДЫ ВЫЗЫВАЮТСЯ ВНУТРИ СУБКЛАССОВ
          #ВСЕ ОСТАЛЬНЫЕ МЕТОДЫ ВЫЗЫВАЮТСЯ ИЗВНЕ МЕТОДА TRAIN И ЕГО СУБКЛАССОВ
  
  def speed_up
    @speed += 50
  end

  def stop
    @speed = 0
  end

  def report_previous
    current_route.stations[current_station_index-1]
  end

  def report_next
    current_route.stations[current_station_index+1]
  end

  private

  def validate!
    raise 'НЕВЕРНЫЙ ФОРМАТ НОМЕРА' unless NUMBER_FORMAT.match(@number)
    true 
  rescue => e 
    puts "#{e.message}"
    false
  end
  
end



