require 'set'

input = File.read('6.input').split("\n\n").map { |x| x.split() }

p input.map {  |x| x.map { |y| y.chars.uniq }.flatten.uniq.count }.sum
result = input.map do |x| 
    x.map { |y| Set.new(y.chars) }
     .inject { |product, n| product & n }
     
end

p result.map { |x| x.size }.sum

