moves = File.read('1.input').split("\n").map { (_1[0] == 'L' ? -1 : 1) * _1[1..].to_i }

index = 50
zero_moves = moves.reduce(0) do |count, move|
  index = (index + move) % 100
  count + (index.zero? ? 1 : 0)
end
puts "part one: #{zero_moves}"

result = moves.reduce([50, 0]) do |(index, count), move|
  result = Range.new(*[index, index + move].minmax).count { (_1 % 100).zero? }
  result -= 1 if index.zero?

  [(index + move) % 100, count + result]
end

puts "part two: #{result[1]}"