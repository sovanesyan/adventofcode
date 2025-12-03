ranges = File.read('2.input').gsub("\n", '')
             .split(',')
             .map { _1.split('-').map(&:to_i) }
             
ids = ranges.map { Range.new(_1[0], _1[1]).to_a }.flatten
             
             
def part_one(word) = word[0...word.length / 2] == word[word.length / 2..]

p ids.filter { part_one(_1.to_s) }.to_a.sum

def part_two(word) = (1..word.size/2).any? { word.chars.each_slice(_1).map(&:join).uniq.size == 1 }

p ids.filter { part_two(_1.to_s) }.to_a.sum