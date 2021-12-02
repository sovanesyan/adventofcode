def read_instructions
    File.read('8.input').split("\n").map { |x| x.split }
end

input = read_instructions

def solve input
    acc = 0
    index = 0 
    visited = []

    loop do
        instruction, value = input[index]
        #p "instruction: #{instruction}, value #{value}"
        case instruction
        when 'nop'
            index += 1
        when 'acc'
            index += 1
            acc += value.to_i
        when 'jmp'
            index = index + value.to_i
        end

        break if (index >= input.size)
        break if visited.include? index
        visited << index
    end
    [acc, (index >= input.size)]
end

p part1 = solve(input)
p part1 = solve(input)

input.each_with_index do |instruction, index| 
    next if instruction[0] == 'acc'

    cloned = read_instructions
    case instruction[0]
    when 'nop'
        cloned[index][0] = 'jmp'
    when 'jmp'
        cloned[index][0] = 'nop'
    end
    p solved = solve(cloned)
    break if solved[1]
end