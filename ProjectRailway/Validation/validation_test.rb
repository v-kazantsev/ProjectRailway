require_relative 'class_station'
require_relative 'module_validation'
class Test
  include Validation
  attr_accessor :name, :station
  validate :name, :presence
  validate :name, :format, /\A\w+/i
  validate :station, :type, Station
end

t = Test.new
t.name = 'Msk'
t.station = Station.new(t.name)
puts t.valid? ? 'passed' : 'not_passed'
