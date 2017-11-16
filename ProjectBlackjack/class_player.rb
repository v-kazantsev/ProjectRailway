require_relative 'class_gambler'
class Player < Gambler
  attr_accessor :cards_qtty
  def initialize
    super
    @cards_qtty = 0
  end
end