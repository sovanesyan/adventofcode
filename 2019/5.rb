input = File.read('5.input').split(',').map { |x| x.to_i }

def peek memory, index, mode
    mode == 1 ? memory[index] : memory[memory[index]]
end

def store memory, index, mode, value
    if mode == 1
        memory[index] = value 
    else 
        memory[memory[index]] = value
    end
end

def execute memory
    pointer = 0

    loop do 
        opcode = memory[pointer].digits.take(2).reverse.join.to_i
        mode1 = memory[pointer].digits[2] || 0
        mode2 = memory[pointer].digits[3] || 0 
        mode3 = memory[pointer].digits[4] || 0
        #p memory.first(10)
        #p "Opcode: #{opcode} from instruction #{memory[pointer]} at pointer[#{pointer}]."

        case opcode
        when 1
            result = peek(memory, pointer+1, mode1) + peek(memory, pointer+2, mode2)
            store(memory, pointer+3, mode3, result)
            pointer += 4
        when 2 
            result = peek(memory, pointer+1, mode1) * peek(memory, pointer+2, mode2)
            store(memory, pointer+3, mode3, result)
            pointer += 4
        when 3
            puts "Input requested"
            store(memory, pointer+1, mode1, gets.to_i)
            pointer += 2
        when 4
            puts peek(memory, pointer+1, mode1)
            pointer += 2
        when 5
            if peek(memory, pointer+1, mode1) != 0
                pointer = peek(memory, pointer+2, mode2) 
            else
                pointer += 3
            end
        when 6
            if peek(memory, pointer+1, mode1) == 0
                pointer = peek(memory, pointer+2, mode2) 
            else
                pointer += 3
            end
        when 7
            result = peek(memory, pointer+1, mode1) < peek(memory, pointer+2, mode2)
            store(memory, pointer+3, mode3, result ? 1 : 0)
            pointer += 4
        when 8
            result = peek(memory, pointer+1, mode1) == peek(memory, pointer+2, mode2)
            store(memory, pointer+3, mode3, result ? 1 : 0)
            pointer += 4
        when 99
            break
        else    
            pointer += 1
        end
    end

    return memory
end

execute(input.clone)

