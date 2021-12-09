input = File.read('8.input').lines


problem1 =  input.map do |line|
  signals, outputs = line.split("|").map(&:split)
  outputs.count { [2,4,3,7].include? _1.size}
end.sum
p problem1

problem2 =  input.map do |line|
  signals, outputs = line.split("|").map(&:split)
  signals.map! { _1.chars.sort.join }
  outputs.map! { _1.chars.sort.join }

  the_one = signals.select { _1.size == 2 }.first
  the_seven = signals.select { _1.size == 3 }.first
  the_four = signals.select { _1.size == 4 }.first
  the_eight = signals.select { _1.size == 7 }.first
  
  char_count = signals.map(&:chars).flatten.tally
  a = [the_seven.chars - the_one.chars].flatten.first
  c = (char_count.select { |_, value| value == 8 }.keys - [a]).first
  f = (the_seven.chars - [a,c]).first
  e = char_count.select { |_, value| value == 4 }.keys.first
  b = char_count.select { |_, value| value == 6 }.keys.first
  d = (the_four.chars - [b, c, f]).first
  g = (the_eight.chars - [a,b,c,d,e,f]).first
  
  the_two = [a,c,d,e,g].sort.join
  the_three = [a,c,d,f,g].sort.join
  the_five = [a,b,d,f,g].sort.join
  the_six = [a,b,d,e,f,g].sort.join
  the_nine = [a,b,c,d,f,g].sort.join
  the_zero = [a,b,c,e,f,g].sort.join

  translator = {
    the_zero => 0,
    the_one => 1,
    the_two => 2, 
    the_three => 3,
    the_four => 4, 
    the_five => 5,
    the_six => 6, 
    the_seven => 7, 
    the_eight => 8, 
    the_nine => 9
  }

  outputs.map { translator[_1] }.join.to_i
end.sum
p problem2
