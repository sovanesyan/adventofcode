l = File.read('6.input').split
l.each do |line|
    line.chars.each.with_index do |char, index|
        sub = line.slice(index, 4) 
        if sub.chars.uniq.count == 4
            p index+4
            break
        end
    end
end

l = File.read('6.input').split
l.each do |line|
    line.chars.each.with_index do |char, index|
        sub = line.slice(index, 14) 
        if sub.chars.uniq.count == 14
            p index+14
            break
        end
    end
end