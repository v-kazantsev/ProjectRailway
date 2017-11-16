class Gambler
  attr_accessor :money, :points, :hand
  def initialize
    @money = 100
    @points = 0
    @hand = []
  end
  def make_bet
    self.money -= 10
  end
end