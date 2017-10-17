class Route
  def initialize(start,finish)
    @start = start
    @finish = finish
    @route = [@start,@finish]
  end
  attr_accessor :name, :route
  def add_station(name)
    self.route.insert(-2, name)
  end
  def remove_station(name)
    self.route.delete(name)
  end
  def route_list
    puts route
  end
end

