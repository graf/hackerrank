# Enter your code here. Read input from STDIN. Print output to STDOUT

def next_permutation(array)
  # Find longest non-increasing suffix
  i = array.length - 1
  while i > 0 && array[i - 1] >= array[i] do
    i -= 1
  end
  # Now i is the head index of the suffix

  # Are we at the last permutation already?
  return false if i <= 0

  # Let array[i - 1] be the pivot
  # Find rightmost element that exceeds the pivot

  j = array.length - 1

  while array[j] <= array[i - 1] do
    j -= 1;
  end
  # Now the value array[j] will become the new pivot
  # Assertion: j >= i

  # Swap the pivot with j
  temp = array[i - 1]
  array[i - 1] = array[j]
  array[j] = temp

  # // Reverse the suffix
  j = array.length - 1
  while i < j do
    temp = array[i]
    array[i] = array[j]
    array[j] = temp
    i+=1
    j-=1
  end

  # Successfully computed the next permutation
  true
end


lines_count = gets.to_i

lines_count.times do
  s = gets.chomp
  array = s.split('')
  if next_permutation(array)
    puts array.join('')
  else
    puts 'no answer'
  end
end