input = File.read("1.input").split.map { |x| x.to_i }
p input.sum


input = File.read("1.input").split.map { |x| x.to_i } * 1000
frequency = 0
frequencies = { 0 => true } 

input.each do |x| 
    frequency += x

    if frequencies.has_key? frequency 
        p frequency
        break
    end

    frequencies[frequency] = true 
end