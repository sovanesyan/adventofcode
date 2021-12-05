input = File.read("2.input").split("\n").map &:split

position = depth = 0

input.each do |command, value|
    case command
    when "forward"
        position += value.to_i
    when "down"
        depth += value.to_i
    when "up"
        depth -= value.to_i
    end
end

puts position * depth
position = depth = aim = 0

input.each do |command, value|
    case command
    when "forward"
        position += value.to_i
        depth += aim * value.to_i
    when "down"
        aim += value.to_i
    when "up"
        aim -= value.to_i
    end
end

puts position * depth