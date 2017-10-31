require_relative 'module'

class Wagon
  
  include Maker
  include Valide

  attr_reader :type
  
  def initialize(type)
    @type = type
  end

end
