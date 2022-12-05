require 'open-uri'

stacks = {}

stack_diagram = open('initial_stacks.txt').readlines(chomp: true)

stack_diagram.each do |line|
  line.chars.each_with_index do |char, index|
    if char =~ /[A-Z]/
      stack_number = (index + 3) / 4
      if stack = stacks[stack_number]
        stack.unshift(char)
      else
        stacks[stack_number] = [char]
      end
    end
  end
end

instructions = []

open('instructions.txt').readlines(chomp: true).each do |line|
  /move (?<n>\d+) from (?<from_column>\d+) to (?<to_column>\d+)/ =~ line
  instructions << { n: n.to_i, from_column: from_column.to_i, to_column: to_column.to_i }
end

instructions.each do |instruction|
  instruction[:n].times do
    stacks[instruction[:to_column]].push(stacks[instruction[:from_column]].pop)
  end
end

puts stacks.sort_by{|k, v| k}.map{|k, v| v.last}.join