NEXT_DIRECTION = { '^' => [-1, 0], '>' => [0, 1], 'v' => [1, 0], '<' => [0, -1],   }

map = File.read('6.input').split("\n").map(&:chars)

def print(map) = puts map.map { _1.join } << "\n"
def start(map) = [map.join.index('^') / map.first.length, map.join.index('^') % map.first.length]
def next_direction(direction) = NEXT_DIRECTION.keys[(NEXT_DIRECTION.keys.index(direction) + 1) %  4]
def next_coordinates(current, direction) = current.zip(NEXT_DIRECTION[direction]).map(&:sum)
def value(map, location) = location.any? { _1.negative? } ? nil : map[location[0]] && map[location[0]][location[1]]    
def looped?(current, next_coordinates, visited) = visited.size.times.select { visited[_1] == current }.any? { visited[_1 + 1] == next_coordinates }
def reset(initial, last, map) 
  map[last[0]][last[1]] = '.'
  map[initial[0]][initial[1]] = '^'
end

def step(current, map, visited = [])
  current_value = value(map, current)
  next_coordinates = next_coordinates(current, current_value)
  next_value = value(map, next_coordinates)

  if looped?(current, next_coordinates, visited)
    [true, visited+[current]]
  elsif next_value == '.' 
    map[current[0]][current[1]] = '.'
    map[next_coordinates[0]][next_coordinates[1]] = current_value

    step(next_coordinates, map, visited + [current])
  elsif next_value == '#' || next_value == 'O'
    map[current[0]][current[1]] = next_direction(current_value)

    step(current, map, visited)
  else 
    [false, visited+[current]]
  end
end

initial = start(map)
looped, full_visited = step(initial, map.map(&:clone).to_a)
reset(initial, full_visited.last, map)

pp full_visited.uniq.size

# Part 2

print map

res = (full_visited-[initial]).uniq.map.with_index do |vis, index|
  i, j = vis

  map[i][j] = 'O'
  #puts "putting a new obstacle"
  looped, visited2 = step(initial, map) 
  #pp visited2
  # print map if looped
  reset(initial, visited2.last, map)
  map[i][j] = '.'
  #puts "obstacle cleared"
  #print map
  
  pp "#{index} / #{full_visited.uniq.size}"
  looped ? 1 : 0
end

pp res.sum 


