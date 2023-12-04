require 'rgl/traversal'
require 'rgl/adjacency'
require 'rgl/dijkstra'
require 'rgl/adjacency'

input = File.read('12.input').split.map(&:chars)

def distance left, right
  left, right = [left, right].map { _1 == "S" ? "a" : _1 }
                             .map { _1 == "E" ? "z" : _1 }
                             .map(&:ord)
  
  right - left
end

def find input, graph, char
  graph.vertices.select do
    x, y = _1.split(":").map(&:to_i) 
    input[x][y] == char
  end
end

def add_edge graph, input, weights, x, y, new_x, new_y 
  if input[new_x] && input[new_x][new_y] && new_x >= 0 && new_y >= 0 && distance(input[x][y], input[new_x][new_y]) <= 1
    weights[["#{x}:#{y}", "#{new_x}:#{new_y}"]] = 1 #distance(input[x][y], input[new_x][new_y])
    graph.add_edge "#{x}:#{y}", "#{new_x}:#{new_y}"
  end 
end

def print_path input, path
  (0...input.size).each do |x|
    line = (0...input[0].size).map do |y|
      path.include?("#{x}:#{y}") ? "#" : "."
    end.join
    p line
  end
end

graph = RGL::DirectedAdjacencyGraph.new

(0...input.size).each do |x|
  (0...input[0].size).each do |y|
    graph.add_vertices "#{x}:#{y}"
  end
end

weights = { }
(0...input.size).each do |x|
  (0...input[0].size).each do |y|
    add_edge(graph, input, weights, x, y, x, y+1)
    add_edge(graph, input, weights, x, y, x, y-1)
    add_edge(graph, input, weights, x, y, x+1, y)
    add_edge(graph, input, weights, x, y, x-1, y)
  end
end

start = find(input, graph, "S").first
destination = find(input, graph, "E").first

path = graph.dijkstra_shortest_path(weights, start, destination)
p path.size - 1

p find(input, graph, "a").push(start)
                         .map { graph.dijkstra_shortest_path(weights, _1, destination)}
                         .select { _1 }
                         .map { _1.size - 1}
                         .min
