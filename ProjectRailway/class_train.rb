class Train
  require_relative "class_route"
  def initialize (number, type, qtty)
    @number = number      #номер поезда
    @type = type          #тип поезда
    @qtty = qtty          #количество вагонов
    @three_way_route = {} #здесь будут храниться текущая, предыдущая и следующая станции маршрута
    @hops = 0             #индекс массива с маршрутом
    @speed = 0            #поезд стоит
  end
  attr_accessor :speed, :qtty, :my_route, :hops
  def take_route(from,to)
    self.my_route = Route.new(from,to) #создаем новый маршрут
    @three_way_route[:current] = from  #и ставим поезд на первую станцию маршрута
    @three_way_route[:next] = to       #пока не заданы промежуточные станции, следующая станция будет конечной
  end
  def speed_up
    self.speed += 80
    puts "Чух-чух-чух"
  end
  def stop
    self.speed = 0
  end
  def add_wagons
    self.qtty += 1 if speed == 0
  end
  def remove_wagons
    self.qtty -=1 if speed == 0
  end 
  def move_forward           
    self.speed_up                       
    self.stop
    self.hops += 1
    @three_way_route[:previous] = my_route.route[hops-1]
    @three_way_route[:current] = my_route.route[hops]
    @three_way_route[:next] = my_route.route[hops+1]
  end
  def move_back
    self.speed_up
    self.stop
    self.hops -=1 
    @three_way_route[:previous] = my_route.route[hops+1]
    @three_way_route[:current] = my_route.route[hops]
    @three_way_route[:next] = my_route.route[hops+1]
  end
  def report_current #сообщает текущую, предыдущую и следующую станции
    puts "Текущая станция #{ @three_way_route[:current] }"
    puts "Следующая станция #{ @three_way_route[:next] }"
    puts "Предыдущая станция #{ @three_way_route[:previous] }"
  end
end



