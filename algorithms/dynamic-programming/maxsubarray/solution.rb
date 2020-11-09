def max_subarray(a)
  max = -Float::INFINITY
  sum = [ [-Float::INFINITY, a[0]].max ] # base case
  (1..a.size - 1).each do |j|
    sum[j] = [-Float::INFINITY, sum[j-1] + a[j]].max # bottom-up
    if sum[j] > max
      max = sum[j]
    end
  end

  max
end

tests_count = gets.to_i

tests_count.times do



  n = gets.to_i

  arr = gets.chomp.split(' ').map(&:to_i)

  puts arr.inspect

  max1 = max_subarray(arr)
  max2 = arr.select { |i| i > 0 }.inject(:+)

  puts [max1, max2].join(' ')
end