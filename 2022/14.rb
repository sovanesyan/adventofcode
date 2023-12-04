input = File.read('14.input').split("\n")
input.map! { |x| x.split("->").map { _1.split(",").map(&:to_i) }}

cave = Hash.new('.')

def apply_rocks input, cave
  input.each do |path|
    path.each_cons(2).each do |left, right|
      minx, maxx = [left[0], right[0]].minmax
      miny, maxy = [left[1], right[1]].minmax
      (minx..maxx).each { |x| (miny..maxy).each { |y| cave["#{x}:#{y}"] = '#' } }
    end
  end
end

def have_it_snow cave, source_x, source_y
  cave["#{source_x}:#{source_y}"] = "+"
  max_y = cave.keys.map { _1.split(':')[1].to_i }.max

  x, y = source_x, source_y 
  loop do 
    if cave["#{x}:#{y+1}"] == '.'
      y += 1 
    elsif cave["#{x-1}:#{y+1}"] == '.'
      x -= 1
      y += 1
    elsif cave["#{x+1}:#{y+1}"] == '.'
      x += 1
      y += 1
    else
      cave["#{x}:#{y}"] = "o"
      break if [x, y] == [source_x, source_y]
      x, y = source_x, source_y 
    end
    break if y > max_y
  end
end

def print cave
  xmin, xmax = cave.keys.map { _1.split(":")[0].to_i }.minmax
  ymin, ymax = cave.keys.map { _1.split(":")[1].to_i }.minmax
  (ymin..ymax).each do |y|
    puts "#{y}: #{(xmin..xmax).map { |x| cave["#{x}:#{y}"] ? cave["#{x}:#{y}"] : "." }.join}"
  end
end

apply_rocks input, cave
have_it_snow cave, 500, 0
#print cave
puts "Part 1: #{cave.values.count { _1 == 'o' }}"

cave = Hash.new('.')

max_y = input.flatten(1).map(&:last).max + 2
input.push([[0, max_y], [2000, max_y]])

apply_rocks input, cave
have_it_snow cave, 500, 0
#print cave
puts "Part 2: #{cave.values.count { _1 == 'o' }}"