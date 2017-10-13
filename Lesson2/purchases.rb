basket = {}
total = 0
loop do 
  puts "Введите товар"
  goods = gets.chomp.downcase
  break if goods == "стоп"
  puts "Введите цену за единицу"
  price = gets.chomp.to_f
  puts "Введите количество"
  qtty = gets.chomp.to_f
  basket[goods] = { price => qtty }
  total = total + price * qtty
  puts basket
  puts price * qtty
end
puts total
