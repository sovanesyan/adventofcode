input = File.read('18.input').gsub("(", " ( ").gsub(")", " ) ")

def handle_parenthesis input, offset
    struct = []
    while (offset < input.length)
        if (input[offset] == "(")
            offset, tmp_array = handle_parenthesis(input, offset + 1)
            struct << tmp_array
        elsif (input[offset] == ")")
            break
        else
            struct << input[offset]
        end
        offset += 1
    end
    return [offset, struct]
end

def apply expression 
    result = expression[0].kind_of?(Array) ? apply(expression[0]) : expression[0]
    result = result.to_i
    operator = expression[1]    

    (2..expression.size).step(2).each do |index|
        expression[index]
        operand = expression[index].kind_of?(Array) ? apply(expression[index]) : expression[index]
        
        if operator == '+'
            result += operand.to_i
        else
            result *= operand.to_i
        end
        operator = expression[index + 1]
    end
    result
end

def apply_advanced expression
    first_addition_index = expression.index '+'
    if first_addition_index
        left_index = first_addition_index - 1
        left_operand = expression[left_index].kind_of?(Array) ? apply_advanced(expression[left_index]) : expression[left_index]

        right_index = first_addition_index + 1
        right_operand = expression[right_index].kind_of?(Array) ? apply_advanced(expression[right_index]) : expression[right_index]

        p result = left_operand.to_i + right_operand.to_i
        p next_array = expression[0...left_index] + [result] + expression[(right_index+1)..expression.size]
        apply_advanced(next_array)
    else
        expression.delete('*')
        expression.map { |x| x.kind_of?(Array) ? apply_advanced(x) : x.to_i }.inject(:*)
    end
end


def calculate input
    p expression = handle_parenthesis(input.split(" "), 0)
    apply(expression[1])
    p apply_advanced(expression[1])
end

p input.split("\n").map { |x| calculate x }.sum
