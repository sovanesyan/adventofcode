
map =  File.read('3.input').split

def check map, x, y
    return nil if y >= map.size

    p "#{y}, #{x}"
    map[y][x % map.first.size] == '#'
end

def count map, x, y, x_next, y_next
    result = check(map, x, y) 
    return 0 if result == nil
    p "#{result}, #{x}, #{y}"

    return (result ? 1 : 0) + count(map, x+x_next, y+y_next, x_next, y_next)
end

x = 0
y = 0

p count(map, 0, 0, 1, 1) *
  count(map, 0, 0, 3, 1) *
  count(map, 0, 0, 5, 1) *
  count(map, 0, 0, 7, 1) *
  count(map, 0, 0, 1, 2)

