require 'matrix'

input = File.read('4.input').split("\n").map(&:chars)

def find(x, y, input) = x >= 0 && y >= 0 && input[x] ? input[x][y] : nil

def check(x, y, input) 
  [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]].map do |dx, dy|
    (0..3).map { find(x+dx*_1, y+dy*_1, input) }.join == 'XMAS'
  end.count(true)
end

result = input.map.with_index do |row, y|
  res = row.map.with_index do |cell, x|
    check(x, y, input)
  end
end

pp result.flatten.sum

def check2(x, y, input)
  return false unless input[x][y] == 'A'
  search_for = ["MS", "SM"]
  search_for.include?([find(x-1, y-1,input), find(x+1, y+1,input)].join) && search_for.include?([find(x-1, y+1,input), find(x+1, y-1,input)].join)
end

result = input.map.with_index do |row, y|
  res = row.map.with_index do |cell, x|
    check2(x, y, input)
  end
end

pp result.flatten.count(true)