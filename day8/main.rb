require 'open-uri'

class TreeGrid
  def initialize
    @grid = {}
  end

  def [](coord)
    @grid[coord]
  end

  def []=(coord, tree)
    @grid[coord] = tree
  end

  def visible_tree_count
    @grid.keys.count do |coord|
      tree_visible_at?(coord)
    end
  end

  def tree_visible_at?(coord)
    min_x = @grid.keys.map { |k| k.x }.min
    max_x = @grid.keys.map { |k| k.x }.max
    min_y = @grid.keys.map { |k| k.y }.min
    max_y = @grid.keys.map { |k| k.y }.max
    (coord.coords_to_left(min_x).all? { |c| @grid[c].height < @grid[coord].height } ||
      coord.coords_to_right(max_x).all? { |c| @grid[c].height < @grid[coord].height } ||
      coord.coords_above(min_y).all? { |c| @grid[c].height < @grid[coord].height } ||
      coord.coords_below(max_y).all? { |c| @grid[c].height < @grid[coord].height })
  end

  def max_scenic_score
    @grid.keys.map do |coord|
      scenic_score(coord)
    end.max
  end

  def scenic_score(coord)
    min_x = @grid.keys.map { |k| k.x }.min
    max_x = @grid.keys.map { |k| k.x }.max
    min_y = @grid.keys.map { |k| k.y }.min
    max_y = @grid.keys.map { |k| k.y }.max
    left_score = coord.coords_to_left(min_x).reverse.index {|c| @grid[c].height >= @grid[coord].height}&.+(1) || coord.x
    right_score = coord.coords_to_right(max_x).index {|c| @grid[c].height >= @grid[coord].height}&.+(1) || (max_x - coord.x)
    above_score = coord.coords_above(min_y).reverse.index {|c| @grid[c].height >= @grid[coord].height}&.+(1) || coord.y
    below_score = coord.coords_below(max_y).index {|c| @grid[c].height >= @grid[coord].height}&.+(1) || (max_y - coord.y)
    left_score * right_score * above_score * below_score
  end
end

Tree = Struct.new(:height)

Coordinate = Struct.new(:x, :y) do
  def coords_to_left(min_x)
    if min_x > x - 1
      []
    else
      (min_x..(x - 1)).map do |new_x|
        Coordinate.new(new_x, y)
      end
    end
  end

  def coords_to_right(max_x)
    if x + 1 > max_x
      []
    else
      ((x + 1)..max_x).map do |new_x|
        Coordinate.new(new_x, y)
      end
    end
  end

  def coords_above(min_y)
    if min_y > y - 1
      []
    else
      (min_y..(y - 1)).map do |new_y|
        Coordinate.new(x, new_y)
      end
    end
  end

  def coords_below(max_y)
    if y + 1 > max_y
      []
    else
      ((y + 1)..max_y).map do |new_y|
        Coordinate.new(x, new_y)
      end
    end
  end
end

grid = TreeGrid.new

open('input.txt').readlines(chomp: true).each_with_index do |line, y|
  line.chars.each_with_index do |height, x|
    coord = Coordinate.new(x, y)
    tree = Tree.new(height.to_i)
    grid[coord] = tree
  end
end

puts grid.visible_tree_count
puts grid.max_scenic_score