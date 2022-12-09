lines = File.read('8.input').split.map(&:chars)
columns = lines.transpose

def is_visible_in_line line, y
    y == 0 || y == line.size - 1 || line[0...y].all? { |x| x < line[y] } || line[(y+1)..].all? { |x| x < line[y] }
end

def scenic_direction line, value
    index = line.find_index { |x| x >= value }
    return index ? index + 1 : line.size
end

def scenic_line line, y
    scenic_direction(line[0...y].reverse, line[y]) * scenic_direction(line[(y+1)..], line[y])
end

visible = 0
trees = []

lines.map.with_index do |line, x| 
    line.map.with_index do |value, y|
        visible += 1 if is_visible_in_line(line, y) || is_visible_in_line(columns[y], x)
        trees << scenic_line(line, y) * scenic_line(columns[y], x)
    end
end
p visible
p trees.max