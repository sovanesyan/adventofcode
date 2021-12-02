input = File.read('2.input').split(',').map { |x| x.to_i }

def execute memory, noun, verb
    memory[1], memory[2] = noun, verb

    (0..memory.rindex(99)).step(4) do |n|
        opcode, first, second, output = memory[n..n+3]
        
        case opcode
        when 1
            memory[output] = memory[first] + memory[second]
        when 2 
            memory[output] = memory[first] * memory[second]
        end
    end

    return memory[0]
end

p execute(input.clone, 12, 2)

sought = 19690720
(0..99).each do |noun|
    (0..99).each do |verb|
        result = execute(input.clone, noun, verb)
        p noun * 100 + verb if result == sought
    end
end
