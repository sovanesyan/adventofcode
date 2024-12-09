map = File.read("8.input").split.map(&:chars)


def find_antenas map
  hash = {}
  searchmap = map.map(&:join).join.chars
  
  searchmap.each_index.select { searchmap[_1].match?(/[A-Za-z0-9]/) }.
    map { [_1 / map[0].size, _1 % map[0].size] }.
    each do |x, y| 
      hash[map[x][y]] ||= []
      hash[map[x][y]] << [x, y]
    end

  hash
end

pp antenas = find_antenas(map)

antinodes = antenas.map do |freq, coords| 
  coords.combination(2).map do |pair|
    a, b = pair
    ax, ay = a
    bx, by = b

    diff_ax = ax-bx
    diff_ay = ay-by

    diff_bx = bx-ax
    diff_by = by-ay

    [[ax + (2 * diff_bx), ay + (2 * diff_by)], [bx + (2 * diff_ax), by + (2 * diff_ay)]]
  end
end
pp antinodes.flatten(2).select { |c|  c.all? { _1 >= 0 && _1 < map.size} && map[c[0]][c[1]] == '.'}.size 