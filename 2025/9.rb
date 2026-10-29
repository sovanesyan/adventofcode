p input = File.read('9.input').split("\n").map { _1.split(",").map(&:to_i) }

Point = Data.define :x, :y do
  def to_s = "#{x},#{y}"
  def x_diff(other) = (x - other.x).abs
  def y_diff(other) = (y - other.y).abs
  def area(other) = (x_diff(other) + 1) * (y_diff(other) + 1)
  def points_in_rectangle(other) 
    xmin, xmax = [x, other.x].minmax
    ymin, ymax = [y, other.y].minmax
    (xmin..xmax).map { |x| (ymin..ymax).map { |y| [x, y] }}.flatten(1)
  end
  def equals(x, y) = self.x == x && self.y == y
  def points_between(other) 
    if x_diff(other) == 0
      start, ending = [y+1, other.y].minmax
      (start...ending).map { Point.new(x: x, y: _1) }
    elsif y_diff(other) == 0
      start, ending = [x+1, other.x].minmax
      (start...ending).map { Point.new(x: _1, y: y) }
    else
      []
    end
  end
end

red_tiles = input.map { Point.new(x: _1[0], y: _1[1]) }

p red_tiles.combination(2).map { |a, b| a.area(b) }.max

def ranges(tiles) = tiles.map(&:x).minmax.zip([-2, 2]).map(&:sum) + tiles.map(&:y).minmax.zip([-1, 1]).map(&:sum)
  
def print_grid(red_tiles, green_tiles = [])
  red_tiles_hash = red_tiles.map { [_1.to_s, 1] }.to_h
  green_tiles_hash = green_tiles.map { [_1.to_s, 1] }.to_h

  xmin, xmax, ymin, ymax = ranges(red_tiles)

  (ymin..ymax).each do |y|
    (xmin..xmax).each do |x|
      print red_tiles_hash.key?("#{x},#{y}") ? "#" : 
            green_tiles_hash.key?("#{x},#{y}") ? "X" :
            "."
    end
    puts
  end
end

green_tiles = red_tiles.combination(2).map { _1.points_between(_2) }.flatten
#print_grid(red_tiles, green_tiles)

tiles = (red_tiles + green_tiles).map { [_1.to_s, _1] }.to_h


def flood_fill_iterative(tiles, start)
  visited = []
  queue = [start]

  xmin, xmax, ymin, ymax = ranges(tiles.values)

  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]

  until queue.empty?
    current = queue.shift
    next if visited.include?(current)
    visited << current

    directions.each do |dx, dy|
      nx, ny = current[0] + dx, current[1] + dy
      next unless nx.between?(xmin, xmax) && ny.between?(ymin, ymax)
      next if tiles.key?("#{nx},#{ny}")
      next if visited.include?([nx, ny])
      queue << [nx, ny]
    end

    #p "visited #{visited.size} queue #{queue.size} out of total: #{(xmax-xmin+1) * (ymax-ymin+1)}"
  end

  visited
end

p xses_index = tiles.values.map(&:x).sort.uniq.each_with_index.map { [_1, _2] }.to_h
p yses_index = tiles.values.map(&:y).sort.uniq.each_with_index.map { [_1, _2] }.to_h
p tiles = tiles.values.map { Point.new(x: xses_index[_1.x], y: yses_index[_1.y]) }.map { [_1.to_s, _1] }.to_h
xmin, xmax, ymin, ymax = ranges(tiles.values)
outside = flood_fill_iterative(tiles, [xmin, ymin])
outside = outside.map { [xses_index.key(_1[0]), yses_index.key(_1[1])] }
p outside
filled = (xmin..xmax).map { |x| (ymin..ymax).map { |y| [x, y] }}.flatten(1) - outside

print_grid(filled.map { Point.new(x: _1[0], y: _1[1]) })

p "start"
p red_tiles.combination(2).
  map { _1.points_in_rectangle(_2) }.
  filter { (_1 - filled).empty? }.
  map(&:size).max
  