input = File.read('24.input').split

input = input.map { |x| x.gsub("e", "e,").gsub("w", "w,").split(',') }

tiles = { }

class Tile 
    attr_accessor :x, :y, :z
    attr_accessor :black

    def initialize
        @x, @y, @z = 0, 0, 0
        black = false
    end

    def toggle
        @black = !@black
    end

    def clone
        new_tile = Tile.new
        new_tile.x = @x
        new_tile.y = @y
        new_tile.z = @z
        new_tile.black = @black
        new_tile
    end

    def e
        @x += 1
        @y -= 1

        self
    end
    
    def w
        @x -= 1
        @y += 1
        
        self
    end

    def sw 
        @x -= 1
        @z += 1

        self
    end

    def nw
        @z -= 1
        @y += 1

        self
    end

    def se
        @z += 1
        @y -= 1

        self
    end

    def ne
        @x += 1
        @z -= 1

        self
    end

    def empty_neighbours tiles
        [clone.e, clone.w, clone.se, clone.sw, clone.ne, clone.nw]
                .map do |tile| 
                    tile.black = false
                    tile
                end
                .filter { |tile| !tiles.has_key? tile.key }
    end

    def neighbours tiles
        [clone.e, clone.w, clone.se, clone.sw, clone.ne, clone.nw]
                .filter { |tile| tiles.has_key? tile.key }
                .map { |tile| tiles[tile.key] }
    end


    def evolve tiles
        black_neighbours = neighbours(tiles).filter { |tile| tile.black }.size
        
        #puts "\nTile: " + self.to_s  + " || Black neightbours: " + black_neighbours.to_s
        if black && (black_neighbours == 0 || black_neighbours > 2)
            #puts  "Black goes white"
            toggle
        elsif !black && black_neighbours == 2
            #puts  "White goes black"
            toggle
        else
            #puts "Stays the same"
        end

        self
    end

    def key 
        "#{x}:#{y}:#{z}"
    end
    def to_s
        "x: #{x}, y: #{y}, z: #{z} = #{black ? "Black" : "White" }"
    end
end

def print tiles

    map = tiles.map { |tile| [tile.x, tile.z, tile.black] }
    size = map.map {|x| [x[0].abs, x[1].abs].max }.max 
    matrix = Hash.new
    map.each do |x, z, black| 
        matrix[x] ||= {}
        matrix[x][z] = black 
    end

    
    puts "== printing"
    puts "  " + (-size..size).to_a.map {|x| x.to_s.rjust(2, "+")}.join
    (-size..size).each do |x|
        row = "#{x.to_s.rjust(2, "+")}"
        (-size..size).each do |z|
            if !matrix[x] || matrix[x][z] == nil
                row << "  " 
            else
                row << (matrix[x][z] ? " B" : " W")
            end
        end
        puts row
    end
end

tiles = { }
input.each do |line|
    tile = Tile.new
    line.each { |step| tile.send(step) }
    tiles[tile.key] ||= tile
    tiles[tile.key].toggle
end

puts "Part One: Black Tiles - #{tiles.values.filter { |x| x.black }.size}"


100.times do 
    new_tiles = tiles.values.map { |tile| tile.clone }
    print new_tiles
    new_tiles = new_tiles + new_tiles.map { |x| x.empty_neighbours(tiles) }
    new_tiles.flatten!.uniq!
    
    print new_tiles
    
    new_tiles = new_tiles.map do |x| 
         x.clone.evolve(tiles) 
    end.to_a

    tiles = {}
    new_tiles.filter { |x| x.black }.each { |x| tiles[x.key] = x }
    p tiles.size

    print tiles.values
end

puts "Part Two: Black Tiles - #{tiles.values.filter { |x| x.black }.size}"