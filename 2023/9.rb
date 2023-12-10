input = File.read('9.input').split("\n").map { _1.split.map(&:to_i) }

result = input.map do |line|
  lines = [line]
  until lines.last.all? { _1 == 0 } do
   lines << lines.last.each_cons(2).map { |a, b| (b-a) }
  end

  lines.map { _1.last }.sum
end

result.sum


result = input.map do |line|
  lines = [line]
  until lines.last.all? { _1 == 0 } do
   lines << lines.last.each_cons(2).map { |a, b| (b-a) }
  end

  start = 0
  lines.map { _1.first }.reverse[1..].each { start = _1 - start }
  start 
end

p result.sum
