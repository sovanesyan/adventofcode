l = File.read('3.input').split


def priority character
    res = character.ord - 96
    res > 0 ? res : res + 58 
end

first = l.map do |rucksack| 
    rucksack
    first = rucksack[0, (rucksack.size/2)].chars
    second = rucksack[rucksack.size/2..].chars
    priority (first & second)[0]
end
p first.sum

second = l.each_slice(3).map do |group| 
    priority(group.map(&:chars).inject(&:&)[0])
end
p second.sum
