require 'open-uri'
require_relative 'rucksack'

PRIORITIES = Hash['abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.
  chars.
  each_with_index.
  map { |char, index| [char, index + 1] }]

rucksacks = open('input.txt').readlines(chomp: true).map{|s| Rucksack.new(s)}

puts (rucksacks.map do |rucksack|
  PRIORITIES[rucksack.shared_item]
end.sum)

puts (rucksacks.each_slice(3).map do |slice|
  PRIORITIES[slice.map(&:items).reduce(:&).first]
end.sum)
