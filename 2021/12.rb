require 'Set'

input = File.read("12.input").split.map {_1.split("-")}
paths =  Hash.new
input.each do |start, finish|
  if finish != 'start'
    paths[start] ||= []
    paths[start] << finish
  end
  if start != 'start'
    paths[finish] ||= []
    paths[finish] << start
  end
end

def count_paths(paths, location, small_visited = Set.new)
  return 1 if location == 'end'

  if location != 'start' && location != 'end' && location.downcase == location
    small_visited.add(location)
  end
  
  paths[location].map { |n|
    if small_visited.include?(n)
      0
    else
      count_paths(paths, n, small_visited.dup)
    end
  }.sum
end

def count_paths_two(paths, location, small_visited = Set.new, double_visited = nil)
  return 1 if location == 'end'

  if location != 'start' && location != 'end' && location.downcase == location
    if small_visited.include?(location)
      double_visited = location
    else
      small_visited.add(location)
    end
  end

  paths[location].map { |n|
    if small_visited.include?(n) && !double_visited.nil?
      0
    else
      count_paths_two(paths, n, small_visited.dup, double_visited)
    end
  }.sum
end

p count_paths(paths, 'start')
p count_paths_two(paths, 'start')