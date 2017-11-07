require_relative 'class_station'
require_relative 'class_train'
require_relative 'class_route'
require_relative 'class_cargo_train'
require_relative 'class_passenger_train'
require_relative 'class_wagon'
require_relative 'class_menu'

menu = Menu.new

choice = '0'
until choice == '5'

  puts 'ВЫБЕРИТЕ ДЕЙСТВИЕ:'
  puts '[1] СОЗДАТЬ СТАНЦИЮ'
  puts '[2] СОЗДАТЬ ПОЕЗД'
  puts '[3] СОЗДАТЬ МАРШРУТ'
  puts '[4] УПРАВЛЯТЬ СОЗДАННЫМИ ОБЪЕКТАМИ'
  puts '[5] ВЫХОД'
  choice = gets.chomp

  case choice
  when '1'

    menu.create_station

  when '2'

    menu.create_train

  when '3'

    menu.create_route

  when '4'

    puts '[1] ДОБАВИТЬ СТАНЦИЮ В  МАРШРУТ'
    puts '[2] УБРАТЬ СТАНЦИЮ ИЗ МАРШРУТА'
    puts '[3] НАЗНАЧИТЬ МАРШРУТ ПОЕЗДУ'
    puts '[4] ДОБАВИТЬ ВАГОНЫ'
    puts '[5] УБРАТЬ ВАГОНЫ'
    puts '[6] ПЕРЕМЕСТИТЬ ПОЕЗД ВПЕРЕД'
    puts '[7] ПЕРЕМЕСТИТЬ ПОЕЗД НАЗАД'
    puts '[8] ВЫВЕСТИ ИНФОРМАЦИЮ О ПОЕЗДАХ'
    puts '[9] ВЫВЕСТИ ИНФОРМАЦИЮ О ВАГОНАХ'
    puts '[10] ЗАПОЛНИТЬ ВАГОН'
    puts '[11] ВЫВЕСТИ ИНФОРМАЦИЮ О СТАНЦИЯХ'

    choice1 = gets.chomp

    case choice1
    when '1'

      menu.add_station_to_route

    when '2'

      menu.remove_station_from_route

    when '3'

      menu.assign_route

    when '4'

      menu.add_wagon_by_type

    when '5'

      menu.remove_wagon

    when '6'

      menu.move_train_forward

    when '7'

      menu.move_train_back

    when '8'

      menu.put_trains_info

    when '9'

      menu.show_wagons

    when '10'

      menu.load_wagon

    when '11'

      menu.show_trains

    end
  end
end
