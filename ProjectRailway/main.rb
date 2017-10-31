require_relative 'class_menu'

menu = Menu.new

choice = '0'
until choice == '14' do 
puts "[1] СОЗДАТЬ ПОЕЗД"
puts "[2] СОЗДАТЬ СТАНЦИЮ"
puts "[3] СОЗДАТЬ МАРШРУТ"
puts "[4] НАЗНАЧИТЬ МАРШРУТ ПОЕЗДУ"
puts "[5] ДОБАВИТЬ ВАГОНЫ"
puts "[6] УБРАТЬ ВАГОНЫ"
puts "[7] ДОБАВИТЬ СТАНЦИЮ"
puts "[8] УБРАТЬ СТАНЦИЮ"
puts "[9] ПЕРЕМЕСТИТЬ ПОЕЗД ВПЕРЕД"
puts "[10] ПЕРЕМЕСТИТЬ ПОЕЗД НАЗАД"
puts "[11] ОТЧЕТ О СТАНЦИЯХ"
puts "[12] ОТЧЕТ О ПОЕЗДАХ"
puts "[13] ОТЧЕТ О МАРШРУТАХ"
puts "[14] ВЫХОД"
choice = gets.chomp
case choice
  when '1'
    menu.create_train
  when '2'
    menu.create_station
  when '3'
    menu.create_route
  when '4'
    menu.assign_route
  when '5'
    menu.add_wagons
  when '6'
    menu.remove_wagons
  when '7'
    menu.add_station
  when '8'
    menu.remove_station
  when '9'
    menu.move_forward
  when '10'
    menu.move_back
  when '11'
    menu.stations_info
  when '12'
    menu.trains_info
  when '13'
    menu.routes_info
end
end


