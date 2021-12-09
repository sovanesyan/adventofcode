input = File.read("9.input").split.map { _1.chars.map(&:to_i) }

def peek input, x, y
  return 10 if [x, y].min < 0
  input[x] != nil && input[x][y] != nil ? input[x][y] : 10
end

def is_low input, x, y
  input[x][y] < [ peek(input, x-1, y), peek(input, x+1, y), peek(input, x, y+1), peek(input, x, y-1) ].min
end

output = input.map.with_index do |row, x|
  row.select.with_index do |_, y|
    is_low(input, x, y)
  end.to_a
end.to_a

p output.flatten.map { _1 + 1 }.sum

def walk input, x, y
  current = peek(input, x, y)
  return [] if [9, 10].include? current

  input[x][y] = 10
  [current, 
   walk(input, x + 1, y),
   walk(input, x - 1, y),
   walk(input, x, y + 1),
   walk(input, x, y - 1)
  ].flatten
end

output = input.map.with_index do |row, x|
  row.map.with_index do |_, y|
    if is_low(input, x, y) 
      walk(input, x, y)
    else
      []
    end
  end.to_a
end.to_a

p output.flatten(1).map(&:size).sort.reverse.take(3).inject(:*)