require 'rgl/traversal'
require 'rgl/adjacency'
require 'rgl/dijkstra'
require 'rgl/adjacency'

input = File.read("15.input").split.map { _1.chars.map(&:to_i)}

def add_edge graph, input, weights, x, y, new_x, new_y 
  if input[new_x] && input[new_x][new_y] && new_x >= 0 && new_y >= 0
    weights[["#{x}:#{y}", "#{new_x}:#{new_y}"]] = input[new_x][new_y] 
    graph.add_edge "#{x}:#{y}", "#{new_x}:#{new_y}"
  end 
end

def solve input
  graph = RGL::DirectedAdjacencyGraph.new
  
  (0..input.size).each do |x|
    (0..input[0].size).each do |y|
      graph.add_vertices "#{x}:#{y}"
    end
  end

  weights = { }
  (0..input.size).each do |x|
    (0..input[0].size).each do |y|
      add_edge(graph, input, weights, x, y, x, y+1)
      add_edge(graph, input, weights, x, y, x, y-1)
      add_edge(graph, input, weights, x, y, x+1, y)
      add_edge(graph, input, weights, x, y, x-1, y)
    end
  end

  path = graph.dijkstra_shortest_path(weights, "0:0", "#{input.size-1}:#{input[0].size-1}")
  res = path[1..].map do |vertice|
    x, y = vertice.split(":").map(&:to_i)
    input[x][y]
  end
  res.sum
end

p solve input

input = (0..4).map do |x|
  input.map do |row| 
    row.map do |cell| 
      new_cell = cell + 1 * x
      new_cell > 9 ? new_cell - 9 : new_cell
    end
  end
end

input = input.flatten(1)
input = input.map do |line|
  new_line = (0..4).map do |x|
      line.map do |cell|
      new_cell = cell + 1 * x
      new_cell > 9 ? new_cell - 9 : new_cell
    end
  end

  new_line.flatten(1)
end

p solve input

