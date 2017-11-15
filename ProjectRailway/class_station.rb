#require_relative 'class_train'
require_relative 'module_validation'

class Station
  include Validation
  attr_accessor :trains
  attr_reader :name
  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /\A[a-zа-я]+\z/i


  @@all_stations = {}
  #NAME_FORMAT = /[a-zа-я]+/i

  def initialize(name)
    @name = name
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
end
