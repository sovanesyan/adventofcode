
def parse_map 
    input = File.read('6.input').split.map { |x| x.split(')') }
    map = {}

    input.each do |x, y|
        map[y] = x
    end
    map
end

def count_orbits map, current
    count = 0
    while map[current] != 'COM' do 
        count += 1
        current = map[current]
    end
    count
end


p map = parse_map 
p map.keys.map { |x| count_orbits(map, x) + 1 }.sum

current = 'YOU'

def follow(map, current) 
    orbits = []

    while map[current] != nil do 
        orbits << current
        current = map[current]
    end

    orbits
end

visited1 = follow(map, 'YOU')
visited2 = follow(map, 'SAN')

visited1.each_index do |lindex|
    rindex = visited2.index visited1[lindex]
    if rindex
        p visited1[1...lindex].size + visited2[1...rindex].size
        break
    end
end
