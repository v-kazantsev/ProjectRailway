puts "Какое сегодня число?"
date_number = gets.chomp.to_i
puts "Какой месяц?"
month = gets.chomp.downcase
case month
  when "январь"
    month_num = 0
  when "февраль"
    month_num = 1
  when "март"
    month_num = 2
  when "апрель"
    month_num = 3
  when "май"
    month_num = 4
  when "июнь"
    month_num = 5
  when "июль"
    month_num = 6
  when "август"
    month_num = 7
  when "сентябрь"
    month_num = 8
  when "октябрь"
    month_num = 9
  when "ноябрь"
    month_num = 10
  when "декабрь"
    month_num = 11
  else 
    puts "Ошибка"
    month_num = 0 #По-хорошему тут нужен loop пока пользователь не введет месяц правильно
end
puts "Какой год?"
year = gets.chomp.to_i
days_of_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_of_month[1] = 29 if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
for i in 1..month_num
  date_number = date_number + days_of_month[i]
end
puts "Сегодня #{date_number}й день с начала года"

 




