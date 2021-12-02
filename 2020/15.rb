#memory = [0,3,6]
memory = [0,20,7,16,1,18,15]

last_occurence = {

}

memory.each.with_index do |value, index|
    last_occurence[value] = index
end

(memory.size...30000000).each do |index|
    last = memory.last
    last_last = last_occurence[last]

    memory[index] = last_last == nil ? 0 : (index-1) - last_last
    last_occurence[last] = index - 1 
end

p memory.last