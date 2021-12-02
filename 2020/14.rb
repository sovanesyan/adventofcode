def read_input 
    input = File.read('14.input').split('mask = ')
    input = input[1..].map do |x| 
        mask = x.split("\n")[0]
        allocations = x.split("\n")[1..].map do |y|
            allocation = y.split(' = ')
            allocation[0] = allocation[0][4..-2]
            allocation
        end

        [mask, allocations]
    end
end

def part_one
    memory = {} 
    read_input.each do |mask, allocations|
        p "mask: #{mask}"
        allocations.each do |index, value|
            binary_value = value.to_i.to_s(2).rjust(36, "0")
            p "value: #{value}, to_s #{binary_value}"
            mask.chars.each.with_index do |value, index| 
                next if value == 'X'
                binary_value[index] = value
            end
            p "masked value: #{binary_value.to_i(2)}"
            
            memory[index] = binary_value.to_i(2)
        end
    end

    p memory.values.sum
end 

def part_two
    memory = {} 
    read_input.each do |mask, allocations|
        p "mask: #{mask}"
        allocations.each do |index, value|
            binary_value = index.to_i.to_s(2).rjust(36, "0")
            
            mask.chars.each.with_index do |value, index| 
                next if value == '0'
                binary_value[index] = value
            end
            p "index: #{index}, to_s #{binary_value}"
            size = binary_value.chars.count { |x| x == 'X' }            
            
            [0,1].repeated_permutation(size).to_a.each do |xses|
                address = binary_value.clone()
                address.chars.each.with_index do |value, index|
                    address[index] = xses.pop.to_s if value == 'X'
                end
                memory[address] = value.to_i
            end
        end
    end

    p memory.values.sum
end

part_two