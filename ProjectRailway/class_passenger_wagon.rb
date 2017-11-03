require_relative 'class_wagon'

class PassengerWagon < Wagon
  
  attr_reader :seats_free, :seats
  attr_accessor :seats_taken

  def initialize(type,seats)
    super(type)
    @seats = seats
    @seats_taken = 0 
  end

  def take_seat
    self.seats_taken += 1 if seats_free > 0
  end

  def seats_taken
    @seats_taken
  end

  def seats_free
    @seats_free = @seats - seats_taken
  end

end
