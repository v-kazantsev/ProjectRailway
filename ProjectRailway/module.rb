module Maker
  attr_accessor :maker_name
  def set_maker(maker)
    maker_name = maker
  end

  def get_maker
    self.maker_name
  end
end