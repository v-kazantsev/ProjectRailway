require_relative 'class_wagon'

class PassengerWagon < Wagon
  attr_reader :seats
  attr_writer :seats_taken

  def initialize(type, seats)
    super(type)
    @seats = seats
    @seats_taken = 0
  end

  def take_seat
    self.seats_taken += 1 if seats - seats_taken > 0
  end

  attr_reader :seats_taken
end
