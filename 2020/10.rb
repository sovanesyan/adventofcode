
def part_one
    input = File.read('10.input').split.map { |x| x.to_i }.sort

    p input.sort

    input << input.max + 3
    input.unshift(0)
    p input = input.each_with_index.map { |x, index| x - input[index-1] }
    input[0]=0
    p ones = input.count { |x| x == 1 } 
    p threes = input.count { |x| x == 3 }
    p ones * threes
end

input = File.read('10.input').split.map { |x| x.to_i }.sort
input.unshift(0)
input << input[-1]+3



def count_chains memory, input, current, last
    return 0 if current == nil

    if memory[current * 100 + last] != nil
        return memory[current * 100 + last]
    end

    p "current: #{current}, last: #{last}"
    return 0 if current - last > 3
    return 1 if current == input.last
    current_index = input.index(current)

    result =   count_chains(memory, input, input[current_index+1], current) + 
               count_chains(memory, input, input[current_index+2], current) +
               count_chains(memory, input, input[current_index+3], current) 

    memory[current*100 + last] = result

    return result
end

memory = {} 
p count_chains(memory, input, 1, 0) + 
  count_chains(memory, input, 2, 0) + 
  count_chains(memory, input, 3, 0)