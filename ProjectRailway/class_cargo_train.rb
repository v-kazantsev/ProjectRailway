class CargoTrain < Train
  attr_reader :type
  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-*[a-zа-я0-9]{2}$/i
  
  def initialize(number)
    super
    @type = :cargo 
  end
  
end
