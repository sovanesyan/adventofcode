def part_one

    input = File.read('17.input').split("\n").map { |x| x.chars }

    cube = { 0 => {} } 
    (0...input.size).each do |x| 
        cube[0][x] = { }
        input[x].each.with_index do |value, y|
            cube[0][x][y] = value
        end
    end

    def peek cube, x, y, z
        return cube[z][x][y] if cube[z] != nil && cube[z][x] != nil
        return '.'
    end

    def new_state cube, x, y, z
        active = (peek(cube, x, y, z) == "#") ? true : false
        active_neighbours = 0
        
        (z-1..z+1).each do |newz|
            (x-1..x+1).each do |newx|
                (y-1..y+1).each do |newy|
                    next if [newz, newx, newy] == [z, x, y]
                    active_neighbours += 1 if peek(cube, newx, newy, newz) == '#'
                end
            end
        end
        #p "active: #{active}, active_neighbours: #{active_neighbours}"
        
        
        return [2, 3].include?(active_neighbours) ? '#' : '.' if active 
        return active_neighbours == 3 ? '#' : '.' 
    end

    def evolve cube
        minz = cube.keys.minmax.first - 1
        maxz = cube.keys.minmax.last + 1
        minx = cube.values.first.keys.minmax.first - 1
        maxx = cube.values.first.keys.minmax.last + 1
        miny = cube.values.first.values.first.keys.minmax.first - 1
        maxy = cube.values.first.values.first.keys.minmax.last + 1
        
        evolved = { }
        (minz..maxz).each do |z|
            evolved[z] = { } if evolved[z] == nil
            (minx..maxx).each do |x|
                evolved[z][x] = { } if evolved[z][x] == nil
                (miny..maxy).each do |y|
                    p "new[#{z}][#{x}][#{y}] = #{new_state(cube, x, y, z)}"
                    evolved[z][x][y] = new_state(cube, x, y, z)   
                end
            end
        end 

        evolved
    end

    def print cube
        cube.keys.each do |z|
            p "z=#{z}"
            cube[z].each do |xkey, xvalue|
                puts xvalue.values.join
            end
        end
    end

    #print cube
    6.times do 
        #puts "================="
        cube = evolve cube
        #print cube
    end






    res = cube.values.map do |zvalue|
        res = zvalue.values.map do |xvalue|
            xvalue.values.filter { |yvalue| yvalue == '#' }.size
        end
        res.sum
    end.sum

    p res

end

input = File.read('17.input').split("\n").map { |x| x.chars }

cube = { 0 => { 0 => {} } } 
(0...input.size).each do |x| 
    cube[0][0][x] = { }
    input[x].each.with_index do |value, y|
        cube[0][0][x][y] = value
    end
end

def peek cube, x, y, z, w
    return cube[w][z][x][y] if cube[w] !=nil && cube[w][z] != nil && cube[w][z][x] != nil
    return '.'
end

def new_state cube, x, y, z, w
    active = (peek(cube, x, y, z, w) == "#") ? true : false
    active_neighbours = 0
    
    (w-1..w+1).each do |neww|
        (z-1..z+1).each do |newz|
            (x-1..x+1).each do |newx|
                (y-1..y+1).each do |newy|
                    next if [neww, newz, newx, newy] == [w, z, x, y]
                    active_neighbours += 1 if peek(cube, newx, newy, newz, neww) == '#'
                end
            end
        end
    end
    
    #p "active: #{active}, active_neighbours: #{active_neighbours}"
    
    
    return [2, 3].include?(active_neighbours) ? '#' : '.' if active 
    return active_neighbours == 3 ? '#' : '.' 
end

def evolve cube
    minw = cube.keys.minmax.first - 1
    maxw = cube.keys.minmax.last + 1
    minz = cube.values.first.keys.minmax.first - 1
    maxz = cube.values.first.keys.minmax.last + 1
    minx = cube.values.first.values.first.keys.minmax.first - 1
    maxx = cube.values.first.values.first.keys.minmax.last + 1
    miny = cube.values.first.values.first.values.first.keys.minmax.first - 1
    maxy = cube.values.first.values.first.values.first.keys.minmax.last + 1
    
    evolved = { }
    (minw..maxw).each do |w|
        evolved[w] = { } if evolved[w] == nil
        (minz..maxz).each do |z|
            evolved[w][z] = { } if evolved[w][z] == nil
            (minx..maxx).each do |x|
                evolved[w][z][x] = { } if evolved[w][z][x] == nil
                (miny..maxy).each do |y|
                    #p "new[#{w}][#{z}][#{x}][#{y}] = #{new_state(cube, x, y, z, w)}"
                    evolved[w][z][x][y] = new_state(cube, x, y, z, w)   
                end
            end
        end 
    end
    

    evolved
end

def print cube
    cube.keys.each do |z|
        p "z=#{z}"
        cube[z].each do |xkey, xvalue|
            puts xvalue.values.join
        end
    end
end

#print cube
6.times do 
    #puts "================="
    cube = evolve cube
    #print cube
end





res = cube.values.map do |wvalue|
    wvalue.values.map do |zvalue|
    
        res = zvalue.values.map do |xvalue|
            xvalue.values.filter { |yvalue| yvalue == '#' }.size
        end
        res.sum
    end.sum
end.sum

p res

