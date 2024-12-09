input = File.read("1.input").scan(/\d+/).map(&:to_i).each_slice(2).to_a.transpose

p input.map(&:sort).transpose.map { _1.inject(:-).abs }.sum
p input.first.map { _1 * (input[1].tally[_1] || 0) }.sum