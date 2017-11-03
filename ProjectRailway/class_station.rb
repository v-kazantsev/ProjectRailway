require_relative 'class_train'
require_relative 'module'

class Station

  attr_accessor :trains 
  attr_reader :name

  @@all_stations = {}
  NAME_FORMAT = /[a-zа-я]+/i 
                                     
  def initialize(name)       
    @name = name
    validate!
    @trains = []
    @@all_stations[name] = self
  end

  def self.all                                     
    @@all_stations
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

  def show_trains(trains_block)
    @@all_stations.each do |key,value|
    station = key
      unless value.trains.empty?
        for i in 0..value.trains.size-1
          train_number = value.trains[i].number
          train_type = value.trains[i].type
          train_wagons = value.trains[i].wagons.size
          trains_block.call(station,train_number,train_type,train_wagons)
        end
      else 
      trains_block.call(station, 'НА СТАНЦИИ ПОЕЗДОВ НЕТ')
      end
    end
  end
  

  private

  def validate!
    raise 'НЕВЕРНОЕ ИМЯ СТАНЦИИ' unless NAME_FORMAT.match(name)
  end  

  def valid?
    validate!
    true
    rescue => e
    puts "#{e.message}"
    false
  end  
end
