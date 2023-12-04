
l = File.read('1.input').split("\n")

p l.map { |x| x.chars.filter { _1 == _1.to_i.to_s } }
 .map { [_1.first, _1.last].join.to_i }
 .sum


numbers = { 
  'one' => 'one1one', 'two' => 'two2two', 'three' => 'three3three', 'four' => 'four4four',
  'five' => 'five5five', 'six' => 'six6six', 'seven' => 'seven7seven', 'eight' => "eight8eight",
  'nine' => 'nine9nine'
}

l2 = File.read('1.input').split("\n")

p res =l2.map do |x|  
  numbers.each { |k, v| p x.gsub!(k, v) }
end

p res.map { |x| x.chars.filter { _1 == _1.to_i.to_s } }
    .map { [_1.first, _1.last].join.to_i }
    .sum

