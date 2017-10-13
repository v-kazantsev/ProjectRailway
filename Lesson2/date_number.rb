puts "Какое сегодня число?"
date_number = gets.chomp.to_i
puts "Какой месяц?"
month = gets.chomp
puts "Какой год?"
year = gets.chomp.to_i
month_number = {
'январь' => 0, 'февраль' => 1, 'март' => 2, 'апрель' => 3, 'май' => 4, 
'июнь' => 5, 'июль' => 6, 'август' => 7, 'сентябрь' => 8, 'октябрь' => 9, 
'ноябрь' => 10, 'декабрь' => 11 }
days_of_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_of_month[1] = 29 if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
for i in 1..month_number[month]
  date_number = date_number + days_of_month[i]
end
puts "Сегодня #{date_number}й день с начала года"

 




