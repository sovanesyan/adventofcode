input = File.read("2.input").split("\n").map { _1.scan(/\d+/).map(&:to_i) }

def valid(input)
 result = input.each_cons(2).map { |x,y| x-y }
 result.all? { |x| [1, 2, 3].include? x } || result.all? { |x| [-1, -2, -3].include? x }
end

puts input.count { valid(_1) }
puts input.map { _1.combination(_1.count-1) }.count { _1.any? { |x| valid(x) } }