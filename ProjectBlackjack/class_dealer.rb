require_relative 'class_gambler'
require_relative 'class_player'
require_relative 'class_card'
class Dealer < Gambler
  attr_accessor :bank, :player_points, :dealer_points
  def initialize
    super
    @bank = 0
    @player_points = 0
    @dealer_points = 0
  end
  def deal_to_player(player)
    card = Card.new
    player.hand << card
    player.cards_qtty +=1
  end
  def calc_player_points(player)
    for i in 0..player.hand.size-1 do
      @player_points += player.hand[i].value
    end
  end
  def deal_to_dealer
    card = Card.new
    @hand << card
  end
  def calc_dealer_points
    for i in 0..@hand.size-1 do
      @dealer_points += @hand[i].value
    end
  end

end

