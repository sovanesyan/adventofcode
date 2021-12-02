include Math

class Tile 
    def initialize(raw)
        raw = raw.split("\n")
        @name = raw[0].chop
        @data = raw[1..].map { |x| x.chars }
        @neighbours = []
    end
    
    def add value
        @neighbours += value 
    end
    
    def name
        @name 
    end

    def count 
        @neighbours.count
    end

    def neighbours
        @neighbours
    end

    def top 
        @data[0]
    end

    def number
        @name.split[1].to_i
    end

    def right
        @data.map { |row| row.last }
    end

    def left 
        @data.map { |row| row.first }.reverse
    end

    def bottom 
        @data[-1].reverse
    end 
    
    def rotate 
        @data = @data.transpose.map &:reverse
    end

    def flip 
        @data = @data.map { |x| x.reverse }
    end

    def data
        @data 
    end

    def to_s
        result = @name + "\n"
        #result += "Neighbours: #{@neighbours.map{ |x| x.name }}\n"
        result += @data.map { |x| x.join }.join("\n")
    end

    def count_shape(shape)
        count = 0

        (0...@data.size).each do |x|
            (0...@data.first.size).each do |y|
                #x = 2
                #y = 2
                valid = true
                shape.each_with_index do |shape_row, shape_x|
                    shape_row.each_with_index do |shape_cell, shape_y|
                    #p "shape_x: #{shape_x}, shape_y: #{shape_y}, cell: #{shape_cell}"
                    next if shape_cell == 0
                    gx, gy = x + shape_x, y + shape_y
                    #p gx, gy
                    #p @data[gx][gy]
                    if @data[gx] == nil || data[gx] == nil
                        valid = false
                        break
                    end
                    if @data[gx] && @data[gx][gy] != "#"
                        valid = false
                        break
                    end
                    end
                    break unless valid
                end
                #puts "#{x}, #{y}" if valid
                count += 1 if valid
            end
        end

        count
      end

end

is_test = false


input = File.read(is_test ? '20.input.test' : '20.input').split("\n\n").map { |x| Tile.new(x) }

def print matrix 
    puts "### Printing Matrix\n\n"
    matrix.each do |row|
        (0...row.first.data.size).each do |index|
            puts row.map { |x| x.data[index].join }.join(" ")
        end
        puts "\n"
    end
end

input.each do |tile|
    neighbours = input.filter do |other_tile|
        next if tile == other_tile
        [tile.top, tile.right, tile.bottom, tile.left].any? do |line|
            [other_tile.top, other_tile.right, other_tile.bottom, other_tile.left].any? do |other_line|
                other_line == line || other_line == line.reverse
            end
        end
    end

    tile.add neighbours
end

tiles = input

side = sqrt(tiles.size)
matrix = Array.new(side) { Array.new(side, 0) }
matrix[0][0] = tiles.filter { |tile| tile.neighbours.count == 2}.first
matrix[0][1] = matrix[0][0].neighbours.first
matrix[1][0] = matrix[0][0].neighbours.last

def run matrix
    (0...matrix.size).each do |x|
        (0...matrix.size).each do |y|
            next if matrix[x] && matrix[x][y] != 0
            #puts "===x: #{x}, y: #{y}"
    
            neighbours = [[x-1, y], [x+1, y], [x, y-1], [x, y+1]].filter do |coordinates|
                coordinates[0] >= 0 && coordinates[1] >= 0 && matrix[coordinates[0]] && matrix[coordinates[0]][coordinates[1]] != nil && matrix[coordinates[0]][coordinates[1]] != 0
            end.map do |coordinates|
                matrix[coordinates[0]][coordinates[1]]
            end
            #puts "Neighbours: #{neighbours.join("|")}"
            available_choices = neighbours.map { |x| x.neighbours }.inject(:&) || []
            if available_choices.any?
               available_choices = available_choices - matrix.flatten
               matrix[x][y] = available_choices.first if available_choices.size == 1
            end
        end
    end
end

12.times { run matrix }

#puts "###original"
#print matrix

if is_test 
    matrix[0][0].flip
    #puts "###flipped"
    #print matrix

    matrix[0][0].rotate
    #puts "###rotated"
    #print matrix

    matrix[0][0].rotate
    #puts "###rotated twice"
    #print matrix
else 
end

visited = [[0,0]]
(1...matrix.size).each do |x|
    current = matrix[x][0]
    top = matrix[x-1][0]

    4.times do
        current.rotate unless top.bottom == current.top.reverse
    end
    current.flip unless top.bottom == current.top.reverse
    4.times do
        current.rotate unless top.bottom == current.top.reverse
    end
end

#puts "### Fixed 1st column"
#print matrix

(0...matrix.size).each do |x|
    (1...matrix.size).each do |y|
        next if visited.include? [x, y]
        visited << [x, y]

        current = matrix[x][y]
        left = matrix[x][y-1]

        4.times do
            current.rotate unless left.right == current.left.reverse
            #puts "x: #{x}, y: #{y} bohos" if left.right == current.left.reverse
        end
        current.flip unless left.right == current.left.reverse
        4.times do
            current.rotate unless left.right == current.left.reverse
            #puts "x: #{x}, y: #{y} bohos" if left.right == current.left.reverse
        end
    end
end

#print matrix
lines = []
matrix.each do |row|
        
        lines << (1...(row.first.data.size-1)).map do |index|
            row.map do |tile|
                line = tile.data[index]
                line[1...(line.size-1)]
            end.join
        end
        
end

puts picture = Tile.new(lines.unshift("Clean Picture!").join("\n"))
MONSTER_ASCII = [
    '                  # ',
    '#    ##    ##    ###',
    ' #  #  #  #  #  #   '
  ]
  
MONSTER = MONSTER_ASCII.map { |l| l.chars.map { |c| c == '#' ? 1 : 0 } }

#picture.flip
#picture.rotate
#picture.rotate
#picture.rotate
#puts picture
#puts picture.count_shape MONSTER

4.times do 
    monsters = picture.count_shape MONSTER
    if monsters != 0
        puts "something"
        break;
    end
    picture.rotate
end

picture.flip

4.times do 
    monsters = picture.count_shape MONSTER
    if monsters != 0
        puts "monster_count: #{monsters}, left:#{picture.data.flatten.filter { |x| x == "#" }.size - MONSTER.flatten.sum * monsters}"
        break;
    end
    picture.rotate
end

