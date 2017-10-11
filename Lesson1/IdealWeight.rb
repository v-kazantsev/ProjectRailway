puts "What is your name?"
name = gets.chomp
puts "What is your height?"
height = gets.chomp
weight = height.to_i - 110
if weight < 0
 puts "#{name}, your weight is already optimal"
	else 
		puts "#{name}, your ideal weight is #{weight}"
	end