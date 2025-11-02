# puts File.read('10.input')
map = File.read('10.input').split("\n").map(&:chars)


p start = map.each_with_index.map { |row, y| row.each_with_index.map { |c, x| [x, y] if c == 'S' }.compact }.flatten(1).first

def find_next(current_path, map)
  current = current_path.last

  next_directions =
    case map[current[1]][current[0]]
    when '-', '|' then [current.zip(current_path[-2]).map { _1 - _2 }]
    when '7' then [[0, 1], [-1, 0]]
    when 'F' then [[1, 0], [0, 1]]
    when 'J' then [[-1, 0], [0, -1]]
    when 'L' then [[0, -1], [1, 0]]
    end

  return nil unless next_directions

  next_cells = next_directions .map { current.zip(_1).map(&:sum) }.filter { _1 != current_path[-2] }
  next_cell = next_cells.length == 1 ? next_cells.first : nil

  if !next_cell || current_path.include?(next_cell) || !map[next_cell[0]] || !map[next_cell[0]][next_cell[1]]
    nil
  else
    next_cell
  end

  return unless next_cell && map[next_cell[1]] && map[next_cell[1]][next_cell[0]]

  next_cell
end

def print(current_path, map)
  puts map
    .each_with_index
    .map { |row, y|
         "#{row.join} | #{
             row
               .each_with_index
               .map { |_c, x| current_path.include?([x, y]) ? '#' : '.' }
               .join
           }"
       }
         .join("\n")
  puts "\n ---- \n\n"
end

def print_filled(inside, map)
  puts map
    .each_with_index
    .map { |row, y|
         "#{row.join} | #{
             row
               .each_with_index
               .map do |_c, x|
                 if map[y][x] != '.'
                   map[y][x]
                 elsif inside.include?([x, y])
                  'I'
                 else
                   '0'
                 end
               end
               .join
           }"
       }
         .join("\n")
  puts "\n ---- \n\n"
end

directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
paths =
  directions.map do
    # p _1
    current_path = [start, start.zip(_1).map(&:sum)]

    while next_cell = find_next(current_path, map)
      current_path << next_cell
      break if map[next_cell[1]][next_cell[0]] == 'S'
    end

    # print current_path, map
    [_1, current_path]
  end
p paths
results = paths.filter { _1[1].first == _1[1].last }
# to_replace = case results.map(&:first)
#           when [[0, 1], [1, 0]] then 'F'
#           when [[1, 0], [0, 1]] then '7'
#           when [[0, -1], [1, 0]] then 'L'
#           when [[-1, 0], [0, -1]] then 'J'
#           end

path = results.map(&:last).first
# print path, map
# map[start[1]][start[0]] = to_replace
# print path, map
# p path.length

# map.unshift(map[0].size.times.map { '.' })
# map << map[0].size.times.map { '.' }
# map = map.transpose
# map.unshift(map[0].size.times.map { '.' })
# map << map[0].size.times.map { '.' }
# map = map.transpose

# puts map.map(&:join).join("\n")


# map = map.map do |row| 
#   row.each_with_index.map do |c, index|
#     next_c = row[index + 1]

#     if c == '.'
#       ['.', '.'] 
#     elsif c == '-'
#     ['-', '-'] 
#     elsif [c, next_c] == ['F', 'J'] || [c, next_c] == ['F', '7']
#       ['F', '-']
#     elsif [c, next_c] == ['L', 'J'] || [c, next_c] == ['L', '7']
#       ['L', '-']
#     elsif next_c == '-' 
#       [c, '-'] 
#     elsif next_c != '-' 
#       [c, '.'] 
#   end
#   end.flatten
# end
# map = map.transpose.map do |row|
#   row.each_with_index.map do |c, index|
#     next_c = row[index + 1]
#     if c == '.'
#       ['.', '.'] 
#     elsif c == '|'
#     ['|', '|'] 
#     elsif [c, next_c] == ['F', 'L'] || [c, next_c] == ['F', 'J']
#       ['F', '|']
#     elsif [c, next_c] == ['7', 'J'] || [c, next_c] == ['7', 'L']
#       ['7', '|']
#     elsif next_c == '|' 
#     [c, '|'] 
#     elsif next_c != '|' 
#       [c, '.'] 
#   end
#   end.flatten
# end.transpose


# puts map.map(&:join).join("\n")

# def flood_fill(x, y, visited, map)
#   if x < 0 || y < 0 || y >= map.size || x >= map[0].size ||
#      map[y][x] != '.' || visited.include?([x, y])
#     return
#   end

#   visited << [x, y]
#   flood_fill(x + 1, y, visited, map)
#   flood_fill(x - 1, y, visited, map)
#   flood_fill(x, y + 1, visited, map)
#   flood_fill(x, y - 1, visited, map)
# end

# def find_cells(map)
#   visited = []
#   flood_fill(0, 0, visited, map)

#   visited
# end

def inside(x, y, map, path)
  return false if map[y][x] != '.'
  p path
  p sides = [(0...x), (x+1)...map[0].length].map { |range| range.map { |x| path.include?([x, y]) && map[y][x] == '|' }.count { _1 } } + 
      [(0...y), (y+1)...map.length].map { |range| range.map { |y| path.include?([x, y]) && map[y][x] == '-' }.count { _1 } }
  return sides.all? { _1.odd? }
end

def find_cells(map, path)
  inside = []
  map.each_with_index do |row, y|
    row.each_with_index do |c, x|
      next unless inside(x, y, map, path) 

      inside << [x, y]
    end
  end
  inside
end
inside = find_cells(map, path)
print_filled(inside, map)

p inside.length
p map.length * map[0].length
p map.flatten.filter { _1 != '.' }.length
p map.length * map[0].length - map.flatten.filter { _1 != '.' }.length - inside.length

p map[6][2] 
p inside(2, 6, map, path)
p inside.count

