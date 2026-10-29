input = File.read('7.input').split("\n").map(&:chars)

start = [0, input[0].index('S')]

path = [start]

splits = 0
input.each_with_index do |row, current_x|
  nodes_to_follow = path.select { |x, _| x == current_x }.uniq
  nodes_to_follow.each do |x, y |
    if input[x + 1] && input[x + 1][y] == '.'
      path << [x + 1, y]
    elsif input[x + 1]
      splits += 1
      path << [x + 1, y - 1]
      path << [x + 1, y + 1]
    end
  end
end

def next_points(input, path)
  x, y = path.last
  return [[x + 1, y]] if input[x + 1] && input[x + 1][y] == '.'
  return [[x + 1, y - 1], [x + 1, y + 1]] if input[x + 1]
  return []
end

solved = { }
def walk(input, path, solved)
  return solved[path.last] if solved[path.last]
  return 1 if next_points(input, path).size == 0

  res = next_points(input, path).map { walk(input, path + [_1], solved) }.sum
  solved[path.last] = res
  return res
end

def print_grid(input, path = [])
  input.each_with_index do |row, current_x|
    row.each_with_index do |c, current_y|
      if ['S', '^'].include?(c)
        print c 
      elsif path.include?([current_x, current_y])
        print '|'
      else
        print '.'
      end
    end
    puts
  end
end

p splits
p walk(input, [start], solved)
#print_grid(input, path)