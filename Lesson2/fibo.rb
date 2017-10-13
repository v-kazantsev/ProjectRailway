arr = [1,1]
i = 1
while arr[i] < 100 do 
  arr << (arr[-1] + arr[-2])
  i += 1
end
puts arr
