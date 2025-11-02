universe = File.read('11.input').split("\n").map(&:chars)

def print universe
  puts "-----"
  universe.each { |row| puts row.join }
end

def print_galaxies universe, galaxies
  puts "-----"
  universe.each_with_index do |row, y|
    row = row.each_with_index.map do |c, x|
      galaxy_number = galaxies.index([x, y])
      galaxy_number ? galaxy_number+1 : c
    end.join
    puts row
  end
end

galaxies = universe.each_with_index.map do |row, y|
  row.each_with_index.map do |cell, x|
    next if cell == '.'
    [x, y]
  end
end.flatten(1).compact

p ys = universe.each_with_index.map { |row, y| row.all?('.') ? y : nil  }.compact 
p xs = universe.transpose.each_with_index.map { |row, x| row.all?('.') ? x : nil }.compact

print_galaxies universe, galaxies

pairs = galaxies.combination(2).to_a

def distance left, right, xs=[],ys=[], multipler = 1
  left_x, left_y = left 
  right_x, right_y = right

  left_x += xs.filter { _1 < left_x }.count * multipler
  right_x += xs.filter { _1 < right_x }.count * multipler
  left_y += ys.filter { _1 < left_y }.count * multipler
  right_y += ys.filter { _1 < right_y }.count * multipler

  (left_x - right_x).abs + (left_y - right_y).abs
end

p pairs.map { distance(*_1,xs,ys) }.sum
p pairs.map { distance(*_1,xs,ys, 1000000-1) }.sum
