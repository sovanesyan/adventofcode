input = File.read("7.input").split(',').map(&:to_i)
crabs = input.tally 

part_one = crabs.keys.map do |position|
  crabs.map { |index, times| (index-position).abs * times }.sum
end



part_two = crabs.keys.map do |position|
  crabs.map { |index, times| (1..(index-position).abs).sum * times }.sum
end

p part_one.min
p part_two.min
