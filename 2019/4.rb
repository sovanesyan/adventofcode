input = File.read('4.input').split('-').map { |x| x.to_i }
range = Range.new(input[0], input[1])

result = range.filter do |x| 
    x.to_s.chars == x.to_s.chars.sort &&
    x.to_s.chars.group_by { |y| y }.values.any? { |y| y.size == 2 }
end

p result
p result.size