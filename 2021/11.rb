
def print matrix
  matrix.each { puts _1.join }
end


def peek input, x, y
  input[x][y] if input[x] && [x, y].min >= 0
end

def grow input, x, y
  input[x][y] += 1 
end

def grow_all input
  input.map! { _1.map! { |x| x+1 } }
end

def flash input, x, y, flashed
  current = peek(input, x, y)
  return if !current || current <= 9 || flashed.include?([x, y])
  
  flashed << [x, y]
  
  [ 
    [x-1, y], [x-1, y+1], [x-1, y-1],
    [x, y-1], [x, y+1],
    [x+1, y], [x+1, y+1], [x+1, y-1]
  ].each do |side_x, side_y|
    grow(input, side_x, side_y) if peek(input, side_x, side_y)
  end

  flash(input, x-1, y, flashed)
  flash(input, x-1, y+1, flashed)
  flash(input, x-1, y-1, flashed)
  flash(input, x, y+1, flashed)
  flash(input, x, y-1, flashed)
  flash(input, x+1, y, flashed)
  flash(input, x+1, y+1, flashed)
  flash(input, x+1, y-1, flashed)
end

def flash_all input, flashed
  (0..input.size).each do |x|
    (0..input[0].size).each do |y|
      flash(input, x, y, flashed)
    end
  end

  (0..input.size).each do |x|
    (0..input[0].size).each do |y|
      current = peek(input, x, y)
      input[x][y] = 0 if current && current > 9
    end
  end
end

input = File.read("11.input").split.map { _1.chars.map(&:to_i)}

print input
flashes = 0
100.times do 
  grow_all input
  flashed = []

  flash_all(input, flashed)
  flashes += flashed.size
  #puts "-step"
  #print input
end
p flashes

input = File.read("11.input").split.map { _1.chars.map(&:to_i)}

(1..1000).each do |step|

  grow_all input
  flashed = []
  flash_all(input, flashed)

  if flashed.size == input.size * input[0].size
    puts step
    break
  end
end
