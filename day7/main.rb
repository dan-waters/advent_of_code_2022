require 'open-uri'

lines = open('input.txt').readlines(chomp: true)
class Array
  def to_file_path
    if length == 1
      join
    else
      join('/')[1..-1]
    end
  end
end

class Hash
  def nested_set(keys, value)
    if keys.length == 1
      self[keys.first] = value
    else
      self[keys.first] ||= {}
      self[keys.first].nested_set(keys.slice(1..-1), value)
    end
  end

  def total_size
    size = 0
    each do |key, value|
      if value.is_a?(Numeric)
        size += value
      elsif value.is_a?(Hash)
        size += value.total_size
      end
    end
    size
  end
end

file_system = {}
@current_directory = []
@all_directories = []

lines.each do |line|
  if /\$ cd (?<directory>.+)/ =~ line
    if directory == '..'
      @current_directory.pop
    else
      @current_directory.push(directory)
      @all_directories.push(@current_directory.dup) unless @all_directories.include?(@current_directory)
    end
  end

  if /(?<size>\d+) (?<file>.+)/ =~ line
    file_system.nested_set(@current_directory + [file], size.to_i)
  end
end

puts "all directories: #{@all_directories.map(&:to_file_path).join(', ')}"
puts "current direcotry: #{@current_directory.join}"
puts "whole file system: #{file_system}"
puts "total size on fs: #{file_system.total_size}"

puts

@all_directories.each do |dir|
  puts "#{dir.to_file_path} size: #{file_system.dig(*dir).total_size}"
end

puts

puts 'part 1:'
puts "sum of dirs under 100,000: #{@all_directories.map { |dir| file_system.dig(*dir).total_size }.select { |size| size < 100_000 }.sum}"

puts

puts 'part 2'
@required_space = 30000000 - (70000000 - file_system.total_size)
puts "required: #{@required_space}"

dir_to_delete = @all_directories.select { |dir| file_system.dig(*dir).total_size > @required_space }.min_by { |dir| file_system.dig(*dir).total_size }
puts "directory to delete: #{dir_to_delete.to_file_path}"
puts "directory to delete: #{file_system.dig(*dir_to_delete).total_size}"