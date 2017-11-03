require_relative 'class_wagon'

class CargoWagon < Wagon
  
  attr_reader :volume_free, :volume 
  attr_accessor :volume_taken

  def initialize(type,volume)
    super(type)
    @volume = volume
    @volume_taken = 0
  end

  def load(volume)
    self.volume_taken + volume if volume_free > 0
  end

  def volume_taken
    @volume_taken
  end

  def volume_free
    @volume_free = @volume - volume_taken
  end

end