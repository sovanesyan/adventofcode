instructions, map = File.read('8.input').split("\n\n")
map = map.
  split("\n").
  map { _1.split('=').map(&:strip) }.
  map { [_1, _2.scan(/\w+/)] }.
  to_h

current = 'AAA'
steps = 0
instructions.chars.cycle.each do |char|
  break if current == 'ZZZ'
  current = map[current][char == 'L' ? 0 : 1]
  steps += 1
end

p steps

p current = map.keys.filter { _1.end_with?('A') }
steps = 0

current = current.map do |start|
  current_node = start
  steps = 0
  instructions.chars.cycle.each do |char|
    break if current_node.end_with? 'Z'
    current_node = map[current_node][char == 'L' ? 0 : 1]
    steps += 1
  end
  steps
end
p current.reduce(1, :lcm)
p steps