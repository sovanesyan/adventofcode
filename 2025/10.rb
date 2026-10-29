input = File.read('10.input').split("\n")
  .map(&:split)
  .map do  
    [
      _1.first[1..-2], 
      _1[1..-2].map { |b| b[1..-2].split(',').map(&:to_i) }, 
      _1.last[1..-2].split(',').map(&:to_i)
    ]
  end


def repeated_combinations(buttons, joltage = nil)
  Enumerator.new do |y|
    (1..(joltage ? joltage.sum : buttons.size)).each do |size|
      buttons.repeated_combination(size).each do |combination|
        p "new combination"
        y << combination
      end
    end
  end
end

def valid_combination?(lights, combination)
  expected_light = lights.chars.map { _1 == '#' }
  current_light  = Array.new(expected_light.size, false)

  combination.each do |button|
    button.each do |index|
      current_light[index] = !current_light[index]
    end
  end

  expected_light == current_light
end

def valid_joltage?(lights, combination, joltage)
  p "valid joltage"
  hash = combination.flatten.tally
  joltage == (0..hash.keys.max).map { hash[_1] }
end

res = input.map do |lights, buttons|
  repeated_combinations(buttons).find { valid_combination?(lights, _1) }.size
end

p "part one: #{res.sum}"

current = 0

res = input
  .map do |lights, buttons, joltage|
    current += 1
    p "current: #{current} out of #{input.size}"
    repeated_combinations(buttons, joltage).find { valid_joltage?(lights, _1, joltage) }
  end

p "part two: #{res.map(&:size).sum}"