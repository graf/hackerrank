string_count = gets.to_i

strings = Hash.new(0)

string_count.times do
  strings[gets.chomp] += 1
end

queries_count = gets.to_i

queries_count.times do
  puts strings[gets.chomp]
end
