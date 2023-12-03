
l = File.read('1.input').split("\n")

p l.map { |x| x.chars.filter { _1 == _1.to_i.to_s } }
 .map { [_1.first, _1.last].join.to_i }
 .sum


numbers = { 'one' => 'o1o', 'two' => 't2t', 'three' => 't3t', 'four' => 'f4f',
            'five' => 'f5f', 'six' => 's6s', 'seven' => 's', 'eight' => "e8e",
            'nine' => 'n9n', 'zero' => 'z0z'
}

l2 = File.read('1.input').split("\n")

p res =l2.map do |x|  
  numbers.each { |k, v| p x.gsub!(k, v) }
end

p res.map { |x| x.chars.filter { _1 == _1.to_i.to_s } }
    .map { [_1.first, _1.last].join.to_i }
    .sum

