commands = File.read('17.input').chars
shapes = [
  -> y { (2..5).map { [_1, y+4] } }, # ####
  -> y { [[3, y+4],[3, y+5],[3, y+6],[2, y+5],[4, y+5]]}, # x
  -> y { [[2, y+4],[3, y+4],[4, y+4],[4, y+5],[4, y+6]] }, # L
  -> y { (y+4..y+7).map { [2, _1] } }, # |
  -> y { [[2, y+4],[2, y+5],[3, y+4],[3, y+5]] }, # #
]

def print playground
  max_y = [playground.map(&:last).max, 4].max
  (0..max_y).to_a.reverse.each do |y|
    puts "#{y.to_s.rjust(5)}: |#{(0...7).map { |x| playground.include?([x,y]) ? "#" : "." }.join}|" #if y % 863 == 0
  end
  puts "        +-------+"
  puts "\n"
end

playground = []

def gen_next_shape shapes 
  i = 0
  -> { i+=1; shapes[(i-1) % shapes.size] }
end

def gen_next_command commands
  i = 0
  -> { i+=1; commands[(i-1)%commands.size]}
end

next_shape = gen_next_shape shapes
next_direction = gen_next_command commands

def move shape, direction
  shape.map { |x, y| [x + (direction == '<' ? -1 : 1), y] }
end

def down shape
  shape.map { |x, y| [x, y-1] }
end

def can_move shape, playground
  shape.all? { |x, y| x < 7 && x >= 0 } && 
  shape.all? { |x, y| y >= 0 } && 
  (shape & playground).size == 0
end

# rocks = 0
# max_y = -1

# (0...2022).each do |i| 
#   rocks += 1
#   shape = next_shape.call.call(max_y)
#   loop do
#     direction = next_direction.call
#     shape = move(shape, direction) if can_move(move(shape, direction), playground)
#     if can_move(down(shape), playground)
#       shape = down(shape)
#     else 
#       max_y = [max_y, shape.map(&:last).max].max
#       playground = playground + shape
#       break;
#     end
#   end

#   #playground = playground[(playground.size - 20)..] if playground.size > 1000

#   if i % 1000 == 0
#     puts "Iteration: #{i}, Playground size: #{playground.size}"
#   end
# end

# #print playground

# p "Rocks: #{rocks}, Units: #{playground.map(&:last).max + 1}"

cache = {}
rocks = 0
max_y = -1

(0...10000).each do |i| 
  rocks += 1
  shape = next_shape.call.call(max_y)
  loop do
    direction = next_direction.call
    shape = move(shape, direction) if can_move(move(shape, direction), playground)
    if can_move(down(shape), playground)
      shape = down(shape)
    else 
      shape_max_y = shape.map(&:last).max
      cache[i] = (max_y >= shape_max_y) ? 0 : shape_max_y - max_y
      max_y = [max_y, shape.map(&:last).max].max
      playground = playground + shape
      break;
    end
  end

  playground = playground[(playground.size - 1000)..] if playground.size > 2000
  if i % 1000 == 0
    puts "Iteration: #{i}, Playground size: #{playground.size}"
  end
end
p "Rocks: #{rocks}, Units: #{playground.map(&:last).max + 1}"

#p cache.values
#print playground
window_size = 5 
start = cache.values.take(window_size)
p cache.values.take(window_size).size
p cache.values[window_size..].size
p cycle_size = cache.values[window_size..].each_cons(window_size).find_index(start)
p current_y = cache.values[0..cycle_size].sum
#1000000000000 / 45410

#22021581 + 10361