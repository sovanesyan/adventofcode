input = File.read('12.input').split

def turn w, direction
    
    return directions[index + (direction == 'R' ? 1 : -1)]
end

def follow_direction direction, steps
    x, y = 0, 0
    
    case direction
    when 'E'
        y += steps
    when 'N'
        x += steps
    when 'W'
        y -= steps
    when 'S'
        x -= steps
    end
    return x, y
end

def walk line
    visited = []
    x, y, w = 0, 0, [10, 1]

    line.each do |instruction| 
        direction = instruction[0]
        steps = instruction[1..].to_i
        p instruction

        if ['N', 'E', 'S', 'W'].include? direction
            result = follow_direction(direction, steps)
            w[0] += result[1]
            w[1] += result[0]
            p "waypoint #{w}"
        end

        case direction
        when 'L'
            (steps / 90).times do 
                w = w.reverse
                w[0] = w[0] * -1
            end
            p "waypoint #{w}"
        when 'R'
            (steps / 90).times do 
                w = w.reverse
                w[1] = w[1] * -1
            end
            p "waypoint #{w}"
        when 'F'
            steps.times do 
                x += w[0]
                y += w[1]
            end
        end
        p [x, y]
    end

    return [x, y]
end


position = walk(input)
p position.map { |x| x.abs }.sum