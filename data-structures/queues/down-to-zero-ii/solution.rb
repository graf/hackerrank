def process_number_r(number, level)
  if number == 1
    puts level + 1
  end

  next_number =
end

def process_number(number)
  number
end


IO.readlines.each do |line|
  puts process_number(line.chomp.to_i)
end
