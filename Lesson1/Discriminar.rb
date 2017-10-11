puts "Enter a"
a = gets.chomp.to_i
puts "Enter b"
b = gets.chomp.to_i
puts "Enter c"
c = gets.chomp.to_i
d = b**2 - 4*a*c
if d < 0
	puts "#{d}, no roots"
elsif d == 0
	puts "#{d}", -b/(2*a)
else
	d = Math.sqrt(d)
	x1 = (-b + d)/(2*a)
	x2 = (-b - d)/(2*a)
	puts x1, x2
end