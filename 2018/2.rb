input = File.read("2.input").split

twos = input.select do |x|     
    x.chars.group_by { |x| x }.transform_values { |x| x.count }.any? { |x, y| y == 2}
end.count

threes = input.select do |x|     
    x.chars.group_by { |x| x }.transform_values { |x| x.count }.any? { |x, y| y == 3}
end.count

input.combination(2).to_a.each do |x|  
    differences = x[0].chars.zip(x[1].chars).select { |a, b| a != b }
    if differences.count == 1
        p x[0]
        p x[1] 
        p differences
        break
    end
end
