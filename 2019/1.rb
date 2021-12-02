input = File.read("1.input")

def fuel mass
    result = mass / 3 - 2
    return 0 if result <= 0
    result += fuel(result)
    result
end

p input.split.map { |input| fuel(input.to_i) }.sum