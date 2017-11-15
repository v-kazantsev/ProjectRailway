require_relative 'class_station'
require_relative 'class_train'
require_relative 'module_validation'
class Test
  include Validation
  attr_accessor :name, :station
  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /\A\w+/i
  validate :station, :type, Station
end

class Test2
  include Validation
  attr_accessor :number, :train
  validate :number, :presence
  validate :number, :format, /\A[a-zа-я0-9]{3}-*[a-zа-я0-9]{2}\z/i
  validate :train, :type, Train
end

s = Test.new
s.name = 'Msk'
s.station = Station.new(s.name)
puts s.valid? ? 'test1 passed' : 'test1 not passed'

t = Test2.new
t.number = '12345'
t.train = Train.new(t.number)
puts t.valid? ? 'test2 passed' : 'test2 not passed'


