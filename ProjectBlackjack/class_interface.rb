require_relative 'class_player'
class Interface
  attr_accessor :player_name, :choice
  
  def initialize
    @player_name = 'John Doe'
    @choice = '0'
  end
  def ask_name
    puts 'ВАШЕ ИМЯ?'
    self.player_name = gets.chomp
  end
  def show_hands(player,dealer)
    puts format(
      "%25s | %s", "#{player_name}: #{player.hand[0].face}#{player.hand[0].suit}\
  #{player.hand[1].face}#{player.hand[1].suit} ", "ДИЛЕР: *** ***")
puts format("%25s | %s", "У ВАС #{dealer.player_points} ОЧКОВ", "У ДИЛЕРА ")
  end
  def show_table(player,dealer)
    puts format("%25s | %s", "#{player_name}: #{player.money} ГВИНЕЙСКИХ РУПИЙ", "ДИЛЕР: #{dealer.money} ГВИНЕЙСКИХ РУПИЙ")
    puts '-'*56
    puts '               В БАНКЕ 20 ГВИНЕЙСКИХ РУПИЙ'
    puts '-'*56
  end
  def show_open_hands(player,dealer)
    puts format(
      "%25s | %s", "#{player_name}: #{player.hand[0].face}#{player.hand[0].suit}\
  #{player.hand[1].face}#{player.hand[1].suit} ", "ДИЛЕР: \
#{dealer.hand[0].face}#{dealer.hand[0].suit}\
  #{dealer.hand[1].face}#{dealer.hand[1].suit}")
    puts format("%25s | %s", "У ВАС #{dealer.player_points} ОЧКОВ", "У ДИЛЕРА #{dealer.dealer_points} ")
  end
  def show_choice
    puts 'ВАШ ВЫБОР:'
    puts '[1] ПРОПУСТИТЬ ХОД'
    puts '[2] ЕЩЕ КАРТУ'
    puts '[3] ОТКРЫТЬ КАРТЫ'
    self.choice = gets.chomp
  end
  def dealer_pass
    puts 'ДИЛЕР ПРОПУСКАЕТ ХОД'
  end
  def dealer_take_card
    puts 'ДИЛЕР БЕРЕТ КАРТУ'
  end
  def open_cards
    puts 'ВЫ ВЫИГРАЛИ. У ВАС 100 ГВИНЕЙСКИХ РУПИЙ'
    puts '[1] ИГРАТЬ ЕЩЕ'
    puts '[2] ВЫХОД'
  end
end
