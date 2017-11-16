class Card
  attr_accessor :face, :value, :suit
  FACE  = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  VALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 0]
  HEARTS = "\u2661".encode('utf-8')
  DIAMONDS = "\u2662".encode('utf-8')
  CLUBS = "\u2667".encode('utf-8')
  SPADES = "\u2664".encode('utf-8')
  SUIT = [HEARTS, DIAMONDS, CLUBS, SPADES]
  def initialize
    ind = rand(13)
    @face = FACE[ind]
    @value = VALUE[ind]
    @suit = SUIT[rand(4)]
  end
end
