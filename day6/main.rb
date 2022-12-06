require 'open-uri'

stream = open('input.txt').readline(chomp: true)

puts "part 1"
buffer = []

stream.chars.each_with_index do |char, index|
  buffer << char

  if buffer.length > 4
    buffer.shift
  end

  if buffer.length == 4 && buffer.uniq.length == 4
    puts index + 1
    puts buffer.join
    break
  end
end

puts "\npart 2"

stream.chars.each_with_index do |char, index|
  buffer << char

  if buffer.length > 14
    buffer.shift
  end

  if buffer.length == 14 && buffer.uniq.length == 14
    puts index + 1
    puts buffer.join
    break
  end
end