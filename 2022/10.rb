instructions = File.read('10.input').split("\n").map(&:split)
x = [1]
instructions.each do |command, arg|
  case command
  when "noop"
    x << x.last
  when "addx"
    x << x.last
    x << x.last + arg.to_i
  end
end

p (0..5).map { _1 * 40 + 20 }.map { x[_1-1] * _1 }.sum

crt = (0...6).map do |line|
  (0...40).map do |column|
    xp = x[(line * 40) + column]
    (xp-1..xp+1).include?(column) ? "❤️" : " "
  end.join
end

crt.each { p _1 }