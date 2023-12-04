input = File.read('13.input').split("\n\n")

def listify object
  object.is_a?(Array) ? object : [object]
end

def ordered? a, b
  if a.class == Integer && b.class == Integer
    return a > b ? 0 : b > a ? 1 : nil
  else 
    a = [a] if a.class != Array
    b = [b] if b.class != Array
    l = [a.length, b.length].min
    (0...l).each{|i| return ordered?(a[i], b[i]) if ordered?(a[i], b[i])}
    return a.length > b.length ? 0 : b.length > a.length ? 1 : nil
  end
end

res = input.map.with_index do |pair, index|
  left, right = pair.split.map { eval(_1) }
  res = [ordered?(left, right) == 1, index+1]
end

p res.select(&:first).map(&:last).sum

input = File.read('13.input').lines.map(&:strip).reject(&:empty?).map { eval(_1) }
input.push([[2]]).push([[6]])

sorted = input.sort { |a, b| ordered?(b, a)*2 - 1 }
sorted.each { p _1 }

p [[[2]],[[6]]].map { sorted.find_index(_1) + 1}.reduce(&:*)

