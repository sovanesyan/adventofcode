input = File.read('16.input').split("\n")

FLOWS = { }
ROUTES = { }
input.each do |line|
  flow = line.scan(/\d+/)[0].to_i
  source, *destinations = line[1..].scan(/[A-Z]+/).map(&:strip)
  FLOWS[source] = flow
  ROUTES[source] = destinations
end



def part_one(current, visited, minutes)
  
  if visited.uniq.size == FLOWS.size || minutes <= 0
    p visited.uniq
    p "hit bottom #{visited.uniq.size} #{minutes}"
    return 0
  end

  res = 0
  if visited.include?(current)
    res = ROUTES[current].map do |destination|
      part_one(destination, visited + [current], minutes - 1)
    end.max
  else
    flow = FLOWS[current] * minutes
    minutes = minutes - 1
    minutes = minutes - 1 if FLOWS[current] != 0
    res = ROUTES[current].map do |destination|
       part_one(destination, visited + [current], minutes)
    end.max
    res = flow + res
  end

  res
end

p part_one('AA', [], 30)