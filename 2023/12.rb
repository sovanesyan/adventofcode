input = File.read('12.input').split("\n").map(&:split).map { [_1.chars, _2.split(',').map(&:to_i)] }

def count(input)
  result = input.map do |row|
    record, list = row
  
    p unknown_indexes = record.each_with_index.select { |char, index| char == "?" }.map(&:last)
    p known_indexes = record.each_with_index.select { |char, index| char == "#" }.map(&:last)
  
    res = unknown_indexes.to_a.combination(list.sum - record.count("#")).count do |perm|
      [perm + known_indexes].flatten.sort.chunk_while { _1 + 1 == _2 }.map(&:count) == list
    end
  end
end

def solve(lava, nums)
end

result = count(input)

p result.sum

# input = File.read('12.input').split("\n").map { |row| 
#   record, list = row.split
#   [5.times.map { record }.join("?"), 5.times.map { list }.join(",")]
# }
# input.each { |row| p row }

# result = count(input)
# p result.sum