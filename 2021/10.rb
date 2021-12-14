input = File.read("10.input.test").split.map(&:chars)

scanned = input.map do |line|
  stack = []
  result = nil
  
  line.each do |bracket| 
    if ["(", "[", "{", "<"].include? bracket
      stack << bracket
    elsif ["()", "[]", "{}", "<>"].include? stack.last + bracket
      stack.pop
    else
      result = bracket;
      break;
    end
  end

  [result, stack]
end

first_corrupted = scanned.map(&:first)
sum = 0
first_corrupted.compact.each do |x| 
  if x == ")"
    sum += 3
  elsif x == "]"
    sum += 57
  elsif x == "}"
    sum += 1197
  else
    sum += 25137
  end
end
p sum

incomplete = scanned.select { !_1[0] }.map { _1[1] }
incomplete.map! do |stack|
  score = 0
  stack.reverse.each do |x|
    score *= 5
    score += 1 if x == "("
    score += 2 if x == "["
    score += 3 if x == "{"
    score += 4 if x == "<"
  end
  score
end

p incomplete.sort[incomplete.size / 2]