puts "What is your name?"
name = gets.chomp
puts "What is your height?"
height = gets.chomp.to_f
weight = height - 110
if weight < 0
  puts "#{name}, your weight is already optimal"
else 
  puts "#{name}, your ideal weight is #{weight}"
end