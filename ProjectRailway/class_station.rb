require_relative 'class_train'
require_relative 'module'

class Station

  include Valide
  
  attr_accessor :trains 
  attr_reader :name

  @@all_stations = []
  NAME_FORMAT = /[a-zа-я]+/i 

                                          

  def initialize(name)       
    @name = name
    return unless validate! 
    @trains = []
    @@all_stations << self
  end

  def self.all                                     
    @@all_stations
  end 

  def train_in(train)       
    self.trains << train          
  end

  def train_out(train)     
    trains.delete(train)     
  end

  def train_type_list(type)             
    trains.count { |t| t.type == type }
  end

  private

  def validate!
    raise 'НЕВЕРНОЕ ИМЯ СТАНЦИИ' unless NAME_FORMAT.match(@name)
    true
  rescue => e 
    puts "#{e.message}"
    false
  end    
end
