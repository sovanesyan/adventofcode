input, folds = File.read("13.input").split("\n\n")



def print input
  x_max = input.map { _1[0] }.max
  y_max = input.map { _1[1] }.max
  p "matrix now "
  (0..y_max).each do |y|
    line = (0..x_max).map do |x|
      input.include?([x, y]) ? "#" : "."
    end.join

    p line
  end
end

input = input.split.map { |x| x.split(",").map(&:to_i) }

folds.split("\n").each do |fold|
  axis, number = fold.delete_prefix("fold along ").split("=")
  number = number.to_i
  x_max = input.map { _1[0] }.max
  y_max = input.map { _1[1] }.max
  
  if axis == "y"
    input = input.select { |_, y| y != number }
    input = input.map { |x, y| y > number ?  [x, y_max - y] : [x, y]  }
  else
    input = input.select { |x, _| x != number }
    input = input.map { |x, y| x > number ?  [x_max - x, y] : [x, y] }
  end
end

print input
p input.uniq.size
