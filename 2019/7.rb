def read_program 
    
end

class Operation 
    def initialize(memory, pointer)
        @memory = memory
        @pointer = pointer
        @opcode = memory[pointer].digits.take(2).reverse.join.to_i
        @mode1 = memory[pointer].digits[2] || 0
        @mode2 = memory[pointer].digits[3] || 0 
        @mode3 = memory[pointer].digits[4] || 0
    end

    def get_first
        @mode1 == 1 ? @memory[@pointer + 1] : @memory[@memory[@pointer + 1]]
    end

    def set_first value
        @memory[@mode1 == 1 ? @pointer + 1 : @memory[@pointer + 1]] = value
    end

    def get_second 
        @mode2 == 1 ? @memory[@pointer + 2] : @memory[@memory[@pointer + 2]]
    end 

    def set_third value 
        @memory[@mode3 == 1 ? @pointer + 3 : @memory[@pointer + 3]] = value
    end

    def execute pointer
        continue = true

        case @opcode
        when 1
            set_third(get_first + get_second)
            pointer += 4
        when 2 
            set_third(get_first + get_second)
            pointer += 4
        when 3
            puts "Input requested"
            set_first(gets.to_i)
            pointer += 2
        when 4
            puts "Output: #{get_first}"
            pointer += 2
        when 5
            if get_first != 0
                pointer = get_second
            else
                pointer += 3
            end
        when 6
            if get_first == 0
                pointer = get_second
            else
                pointer += 3
            end
        when 7
            set_third(get_first < get_second ? 1 : 0)
            pointer += 4
        when 8
            set_third(get_first == get_second ? 1 : 0)
            pointer += 4
        when 99
            continue = false
        else    
            pointer += 1
        end

        return [pointer, continue]
    end
end

class Program
    def read_input
        File.read('7.input.test').split(',').map { |x| x.to_i }
    end

    def execute
        memory = read_input
        pointer = 0

        loop do 
            op = Operation.new(memory, pointer)
            pointer, continue = op.execute(pointer)
            break unless continue
        end
    
    end

end

$stdin << '3'
Program.new.execute 

