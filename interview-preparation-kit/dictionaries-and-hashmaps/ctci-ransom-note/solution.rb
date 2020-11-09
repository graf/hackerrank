#!/bin/ruby

require 'json'
require 'stringio'

# Complete the checkMagazine function below.
def checkMagazine(magazine, note)
  dict = magazine.each.with_object(Hash.new { 0 }) do |w, dict|
    dict[w] += 1
  end
  
  note.each.with_object(dict) do |w, dict|
    if (dict[w] -= 1) < 0
      puts('No')
      return
    end
  end
  
  puts 'Yes'
end

mn = gets.rstrip.split

m = mn[0].to_i

n = mn[1].to_i

magazine = gets.rstrip.split(' ').map(&:to_s)

note = gets.rstrip.split(' ').map(&:to_s)

checkMagazine magazine, note

