input = File.read("17.input")

x_input, y_input = input[13..].split(", ")
X_MIN, X_MAX = x_input[2..].split("..").map(&:to_i)
Y_MIN, Y_MAX = y_input[2..].split("..").map(&:to_i)


def yield_next x_velocity, y_velocity
  x = y = 0

  loop do 
    x += x_velocity
    y += y_velocity

    y_velocity += -1
    x_velocity += x_velocity > 0 ? -1 : 1 unless x_velocity == 0

    yield x,y
  end
end

def test_velocity x_velocity, y_velocity
  max_y = 0
  result = false
  yield_next(x_velocity, y_velocity) do |x, y| 
    max_y = y if y > max_y
    if (X_MIN..X_MAX).include?(x) && 
       (Y_MIN..Y_MAX).include?(y)
       p "success for #{x_velocity}:#{y_velocity}"
       result = true
       break
    end
  
  
    if y < Y_MIN
      break
    end
  end

  return [result, max_y]
end

p (0..200).to_a.combination(2).map { |x, y| test_velocity(x, y) }
                            .select { |success, _| success}
                            .max

p (-200..200).to_a.product((-300..300).to_a).map { |x, y| test_velocity(x, y) }
                            .select { |success, _| success}
                            .count                            
