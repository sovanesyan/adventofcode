data, moves= File.read('5.input').split("\n\n")

def read data
    stacks = {}
    data.lines.last.chars.map(&:to_i).each.with_index do |x, index| 
        next unless x != 0
        stacks[x] = []
        data.lines.reverse[1..].each do |y|
            stacks[x] << y[index] if y[index] != ' '
        end
    end
    stacks
end

stacks = read data
moves.split("\n").each do |move|
    repeat, from, to = move.sub!("move", "").sub!("from", "").sub!("to", "").split.map(&:to_i)
    repeat.times do 
        stacks[to] << stacks[from].pop
    end
end

p stacks.map { |index, stack| stack.last }.join


stacks = read data
moves.split("\n").each do |move|
    repeat, from, to = move.sub!("move", "").sub!("from", "").sub!("to", "").split.map(&:to_i)
    stacks[to].concat(stacks[from].pop(repeat))
end

p stacks.map { |index, stack| stack.last }.join