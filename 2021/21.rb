input = File.read("21.input").split("\n")

p players = input.map { [_1.split(":")[1].to_i, 0] }

die = Enumerator.new do |y|
  (0..).each do |die|
    y << (die % 100 + 1)
  end
end
  
rolls = 0;
loop do 
  players.each do |player|
    roll = [die.next, die.next, die.next]
    rolls += 3
    position = (roll.sum + player[0])
    position = position % 10 == 0 ? 10 : position % 10
    
    player[0] = position 
    player[1] += position 
    
    #p "roll: #{roll.join('+')} space: #{position}, score: #{player[1]}"
    
    break if player[1] >= 1000
  end

  break if players.any? { _1[1] >= 1000}
end

p players
p players.select { |space, score| score < 1000 }[0][1] * rolls

MEMORY = {} 

def part_two p1, p2, s1, s2
  return [1, 0] if s1 >= 21
  return [0, 1] if s2 >= 21
  input = [p1,p2,s1,s2]
  return MEMORY[input] if MEMORY.has_key? input

  result = [0, 0]
  die = [1,2,3]
  rolls = die.product(die).product(die).map(&:flatten)
  rolls.each do |d1, d2, d3|
    new_p1 = [p1, d1, d2, d3].sum % 10
    new_s1 = s1 + new_p1 + 1

    x1, y1 = part_two(p2, new_p1, s2, new_s1)
    result = [result[0] + y1, result[1] + x1]
  end
  MEMORY[input] = result
  result
end

input = File.read("21.input").split("\n")

p players = input.map { [_1.split(":")[1].to_i, 0] }

p part_two players[0][0]-1, players[1][0]-1, 0, 0
