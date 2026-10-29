Point = Data.define :x, :y, :z do
  def to_s = "#{x},#{y},#{z}"
  def distance(other) = Math.sqrt((x - other.x) ** 2 + (y - other.y) ** 2 + (z - other.z) ** 2)
end

points = File.read('8.input').split("\n").map { _1.split(",").map(&:to_i) }
             .map { Point.new(x: _1[0], y: _1[1], z: _1[2]) }

def sorted_distances points
  Enumerator.new do |y|
    points.combination(2).
      map { [_1, _2, _1.distance(_2)] }.
      sort_by { _3 }.
      each { y << [_1[0], _1[1]] }
  end
end

cirquits = points.map { [_1] }

sorted_distances(points).take(1000).each do |a, b|
  a_cirquit = cirquits.find { _1.include?(a) }
  b_cirquit = cirquits.find { _1.include?(b) }
  next if a_cirquit == b_cirquit

  cirquits.delete(a_cirquit)
  cirquits.delete(b_cirquit)
  cirquits << a_cirquit + b_cirquit
end

#cirquits << points.reject { cirquits.flatten.include?(_1) }.map { [_1] }
cirquits.each { puts [_1, _1.size] }
puts "Total cirquits: #{cirquits.size}"
puts "Result: #{cirquits.sort_by { _1.size }.reverse.take(3).map { _1.size }.inject(:*)}"

cirquits = points.map { [_1] }
sorted_distances(points).each do |a, b|
  a_cirquit = cirquits.find { _1.include?(a) }
  b_cirquit = cirquits.find { _1.include?(b) }
  next if a_cirquit == b_cirquit

  cirquits.delete(a_cirquit)
  cirquits.delete(b_cirquit)
  cirquits << a_cirquit + b_cirquit

  if cirquits.size == 1
    puts "a: #{a}, b: #{b}"
    puts "xses: #{a.x * b.x}"
    puts "Result: #{cirquits.first.size}"
    break
  end
end