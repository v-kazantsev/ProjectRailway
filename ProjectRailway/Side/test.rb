require_relative 'test_module'
class Test
  include InstanceCounter

   def initialize
     register_instance
   end
end

test = Test.new

puts Test.instances #=> 1

test2 = Test.new

puts Test.instances #=> 2