
def stringify grid
    grid.map { |x| x.join }.join("\n")
end 

def peek(grid, x, y)
    return nil unless x.between?(0, grid.size)
    return nil unless y.between?(0, grid.first.size)

    if grid[x]
        grid[x][y]
    else
        nil
    end
end

def new_state(grid, x, y)
    current = grid[x][y]
    
    occupied = 0

    (x-1..x+1).each do |newx|
        (y-1..y+1).each do |newy|
            next if ([x, y] == [newx, newy])
            #p "x: #{newx}, y: #{newy}, grid[x][y]: #{grid[x][y]}"
            occupied += 1 if peek(grid, newx, newy) == '#'
        end
    end
    return '#' if current == 'L' && occupied == 0
    return 'L' if current == '#' && occupied >= 4
    return current
end



def evolve grid, advanced
    result = Array.new(grid.size) { Array.new grid.first.size }
    (0...grid.size).each do |x| 
        (0...grid.first.size).each do |y| 
            result[x][y] = advanced ? advanced(grid, x, y) : new_state(grid, x, y)
        end
    end
    result 
end

def part1
    current = File.read('11.input').split.map { |x| x.chars }
    loop do
        old = current
        current = evolve(current, false)
        puts stringify(current)
        puts "=========="

        break if stringify(old) == stringify(current)
    end

    p current.map { |x| x.count {|y| y == '#' }}.sum
end


def part2
    current = File.read('11.input').split.map { |x| x.chars }

    loop do
        old = current
        current = evolve(current, true)
        puts stringify(current)
        puts "=========="
        break if stringify(old) == stringify(current)
    end

    p current.map { |x| x.count {|y| y == '#' }}.sum
end

def line_occupied grid, x, y
    loop do 
        x, y = yield x, y
        value = peek(grid, x, y)
        return true if value == '#'
        return false if value == 'L'
        break if value == nil
    end
    return false
end

def advanced(grid, x, y)
    current = grid[x][y]
    
    occupied = 0
    occupied += 1 if line_occupied(grid, x, y) { |x, y| [x, y + 1] }
    occupied += 1 if line_occupied(grid, x, y) { |x, y| [x, y - 1] }
    occupied += 1 if line_occupied(grid, x, y) { |x, y| [x + 1, y ] }
    occupied += 1 if line_occupied(grid, x, y) { |x, y| [x - 1, y ] }
    occupied += 1 if line_occupied(grid, x, y) { |x, y| [x + 1, y + 1] }
    occupied += 1 if line_occupied(grid, x, y) { |x, y| [x + 1, y - 1] }
    occupied += 1 if line_occupied(grid, x, y) { |x, y| [x - 1, y + 1] }
    occupied += 1 if line_occupied(grid, x, y) { |x, y| [x - 1, y - 1] }
    
    return '#' if current == 'L' && occupied == 0
    return 'L' if current == '#' && occupied >= 5
    return current
end

part2