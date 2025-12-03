input = File.read('3.input').split("\n").map(&:chars)

def joltage(chars, chars_left)
  return "" if chars_left == 0

  big_index = chars[0..-chars_left].index(chars[0..-chars_left].max)

  (chars[big_index] + joltage(chars[big_index + 1..], chars_left - 1))
end

p input.map { joltage(_1, 2).to_i }.sum
p input.map { joltage(_1, 12).to_i }.sum
