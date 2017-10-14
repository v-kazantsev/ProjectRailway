alphabet = Hash[("а".."я").to_a.zip((1..33).to_a)]
vowels = %(а е ё и о у ы э ю я)
vowels_hash = {}
alphabet.each do |letter, number|
  vowels_hash[letter] = number if vowels.include?(letter)
end
puts vowels_hash



