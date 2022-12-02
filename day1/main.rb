require 'open-uri'

calories = open('input.txt').readlines(chomp: true)

calorie_totals = calories.slice_after {|j| j == ''}.map{|a| a.map(&:to_i)}.map(&:sum)

puts calorie_totals.max

puts calorie_totals.sort.reverse.take(3).sum