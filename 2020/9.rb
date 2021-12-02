input = File.read('9.input').split.map { |x| x.to_i }

def sum?(sum, parts)
    parts = parts.sort

    parts.each_index do |index|
        return true if parts[index+1..].any? { |part| sum == (parts[index] + part)}
    end

    false
end

def find_first_non_sum(input, preamble)
    input.each_index do |index|
        next if index < preamble
        sum = input[index]
        parts = input[index-preamble..index-1]
        
        return sum unless sum?(sum, parts)
    end 
end

def search_for_invalid input, invalid
    input.each_index do |index|
        input[index..].each_index do |next_index|
            p parts = input[index..next_index]
            return parts.minmax.sum if parts.sum == invalid
            break if parts.sum > invalid
        end
    end

end

invalid_number = find_first_non_sum(input, 25)
p input
p weakness = search_for_invalid(input, invalid_number)

    
