class Station
  @@all_stations = []
  NAME_FORMAT = /^\w+/
  attr_reader :name
  attr_accessor :trains 

  def initialize(name)       
    @name = name
    return unless validate!
    @trains = []
    @@all_stations << self 
    puts "СТАНЦИЯ \"#{@name}\" СОЗДАНА"       
  end

  def self.all
    @@all_stations
  end

  def find_station_by_name(name)
    @@all_stations.detect { |n| n.name == name}
  end

  def train_in(train)
    trains << train
  end

  def train_out(train)
    trains.delete(train)
  end

  def train_type_list(type)             
    trains.count { |t| t.type == type }
  end

  def stations_info
    puts '----------'
    self.class.all.each { |x| puts "#{x.name}: ГРУЗОВЫХ ПОЕЗДОВ #{x.train_type_list(:cargo)}, \
    ПАССАЖИРСКИХ ПОЕЗДОВ #{x.train_type_list(:passenger)}" }
    puts '----------'
  end

  private

  def validate!
    raise 'НЕВЕРНЫЙ ФОРМАТ ИМЕНИ' unless NAME_FORMAT.match(name)
    raise 'ТАКАЯ СТАНЦИЯ УЖЕ ЕСТЬ' unless find_station_by_name(name).nil?
    true 
  rescue => e 
    puts "#{e.message}"
    false
  end

  
end
