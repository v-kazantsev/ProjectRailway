require_relative 'test_module'
class Test
  include InstanceCounter

   def initialize
     register_instance
   end
end

test = Test.new

Test.instances #=> 1

test2 = Test.new

Test.instances #=> 2