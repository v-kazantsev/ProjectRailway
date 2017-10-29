module Maker
  attr_accessor :maker_name
end

module Valide
  def valid? 
    validate!
  rescue
    false
  end
end