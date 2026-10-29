input = File.read('6.input').split("\n").map(&:split)

p input.transpose.map { eval(_1[0..-2].join(_1[-1])) }.sum

input = File.read('6.input').split("\n").map(&:chars).transpose.map(&:join)
input = input.slice_when { |a, b| a.strip.empty? || b.strip.empty? }.select { _1.size > 1  }
result = input.map do |row| 
  operator = row[0][-1]
  row[0] = row[0][0..-2]
  eval(row.join(operator))
end.to_a
p result.sum