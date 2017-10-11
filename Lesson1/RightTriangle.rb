puts "Укажите длину первой стороны"
a = gets.chomp.to_f
puts "Укажите длину второй стороны"
b = gets.chomp.to_f
puts "Укажите длину третей стороны"
c = gets.chomp.to_f
if a > b && a > c
  hypotenuse = a
  cathetus1 = b
  cathetus2 = c
elsif b > a && b > c
  hypotenuse = b
  cathetus1 = a
  cathetus2 = c
else 
  hypotenuse = c
  cathetus1 = a
  cathetus2 = b
end
if (hypotenuse**2 == cathetus1**2 + cathetus2**2) && (cathetus1 == cathetus2)
  puts "Это равнобедренный прямоугольный треугольник"
elsif hypotenuse**2 == cathetus1**2 + cathetus2**2
  puts "Это прямоугольный треугольник"
elsif a == b && a == c
  puts "Это равносторонний не прямоугольный треугольник"
else
  puts "Это не прямоугольный треугольник"
end

    
    

      
    
    
    


    
    


    

