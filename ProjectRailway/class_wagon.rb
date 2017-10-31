require_relative 'module'
class Wagon
  attr_reader :type
  include Maker
  include Valide

  def validate!
    raise RuntimeError unless type == :cargo || :passenger
    true
  end
  
  def initialize(type)
    @type = type
    validate!
  end
end
