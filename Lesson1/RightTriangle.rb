puts "Enter first side lenght"
a = gets.chomp.to_f
puts "Enter second side length"
b = gets.chomp.to_f
puts "Enter third side lenght"
c = gets.chomp.to_f
if a > b && a > c && a**2 == b**2 + c**2
		puts "This is a right-angled triangle"
		puts "This is an isosceles triangle" if a == b || a == c || b == c
elsif b > a && b > c && b**2 == a**2 + c**2
		puts "This is a right-angled triangle"
		puts "This ia an isosceles triangle" if a == b || a == c || b == c
elsif c > a && c > b && c**2 == a**2 + b**2
		puts "This is a right-angled triangle"
		puts "This ia an isosceles triangle" if a == b || a == c || b == c
elsif a == b && a == c
	puts "This is an isosceles and equilateral but not right-angled triangle"
else 
	puts "This is not a right-angled triangle"
end
