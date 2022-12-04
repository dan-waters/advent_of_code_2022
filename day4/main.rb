require 'open-uri'
require 'set'

class String
  RANGE_REGEX = /(?<start>\d+)-(?<end>\d+)/

  def parse_as_range
    match_groups = match(RANGE_REGEX)
    match_groups[:start].to_i..match_groups[:end].to_i
  end
end

elf_pairs = open('input.txt').readlines(chomp: true).map do |pair|
  pair.split(',').map(&:parse_as_range)
end

puts elf_pairs.select { |pair| Set.new(pair[0]).superset?(Set.new(pair[1])) || Set.new(pair[1]).superset?(Set.new(pair[0]))}.count

puts elf_pairs.select { |pair| pair[0].cover?(pair[1].first) || pair[1].cover?(pair[0].first)}.count