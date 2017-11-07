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

  def all_trains
    trains.each { |s| yield(s) }
  end

  private

  def validate!
    raise 'НЕВЕРНОЕ ИМЯ СТАНЦИИ' unless NAME_FORMAT.match(name)
  end

  def valid?
    validate!
    true
  rescue RuntimeError => e
    puts e.message.to_s
    false
  end
end
