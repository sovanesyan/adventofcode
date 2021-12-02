require 'Set'
lines = File.read('3.input').split.map { |x| x.split(',')}

def walk line
    visited = []
    x, y = 0, 0

    line.each do |instruction| 
        direction = instruction[0]
        steps = instruction[1..].to_i

        steps.times do 
            case direction
            when 'R'
                y += 1
            when 'U'
                x += 1
            when 'L'
                y -= 1
            when 'D'
                x -= 1
            end

            visited << [x, y]
        end
    end

    visited
end

left = walk(lines[0])
right = walk(lines[1])


result = (left & right).map do |x| 
    left.index(x) + right.index(x)
end.min

p result + 2