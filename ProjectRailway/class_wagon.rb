require_relative 'module'
class Wagon
  attr_reader :type
  include Maker
  
  def initialize(type)
    @type = type
  end
end
