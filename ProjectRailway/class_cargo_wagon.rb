require_relative 'class_wagon'

class CargoWagon < Wagon
  attr_reader :volume
  attr_writer :volume_taken

  def initialize(type, volume)
    super(type)
    @volume = volume
    @volume_taken = 0
  end

  def load(volume_to_load)
    self.volume_taken += volume_to_load if volume - volume_taken > 0
  end

  attr_reader :volume_taken
end
