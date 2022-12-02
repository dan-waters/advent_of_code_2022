require 'open-uri'
require_relative 'round'
require_relative 'round2'

rounds = open('input.txt').readlines(chomp: true)

puts rounds.map{|round| Round.new(round).score}.sum

puts rounds.map{|round| Round2.new(round).score}.sum