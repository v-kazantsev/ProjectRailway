require_relative 'class_route'
require_relative 'class_wagon'
require_relative 'module'
require_relative 'module_validation'

class Train
  include Maker
  include Validation

  attr_accessor :current_route, :current_station_index, :wagons
  attr_reader   :number
  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, /\A[a-zа-я0-9]{3}-*[a-zа-я0-9]{2}\z/i

  #NUMBER_FORMAT = /^[a-zа-я0-9]{3}-*[a-zа-я0-9]{2}$/i
  @@all_trains = {}

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @current_route = []
    @current_station_index = 0
    @@all_trains[number] = self
  end

  def self.all
    @@all_trains
  end

  def self.find(train_number)
    @@all_trains[train_number]
  end

  def current_station
    current_route.stations[current_station_index]
  end

  def take_route(route)
    self.current_route = route
    current_station.train_in(self)
  end

  def add_wagon(wagon)
    wagons << wagon if @speed.zero?
  end

  def remove_wagon(wagon_number)
    wagons.delete_at(wagon_number) if @speed.zero?
    wagons.compact!
  end

  def move_forward
    return if current_station == current_route.stations[-1]
    current_station.train_out(self)
    speed_up
    stop
    self.current_station_index += 1
    current_station.train_in(self)
  end

  def move_back
    return if current_station == current_route.stations[0]
    current_station.train_out(self)
    speed_up
    stop
    self.current_station_index -= 1
    current_station.train_in(self)
  end

  def all_wagons
    wagons.each_with_index { |w, i| yield(w, i) }
  end

  protected # ТОЛЬКО ЭТИ МЕТОДЫ ВЫЗЫВАЮТСЯ ВНУТРИ СУБКЛАССОВ

  # ВСЕ ОСТАЛЬНЫЕ МЕТОДЫ ВЫЗЫВАЮТСЯ ИЗВНЕ МЕТОДА TRAIN И ЕГО СУБКЛАССОВ

  def speed_up
    @speed += 50
  end

  def stop
    @speed = 0
  end

  def report_previous
    current_route.stations[current_station_index - 1]
  end

  def report_next
    current_route.stations[current_station_index + 1]
  end

end
