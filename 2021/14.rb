input, rules = File.read("14.input").split("\n\n")
rules = Hash[rules.split("\n").map { _1.split(" -> ")}]
rules
input 

ITERS = 10

def part_one input, rules
  template = input.dup
  (1..ITERS).each do |iter|
    template = template.chars.each_cons(2).map.with_index do |pair,index|
      [pair.first, rules[pair.join]].join
    end.join + template[-1]
    template
  end

  minmax = template.chars.tally.values.minmax
  (minmax[0] - minmax[1]).abs
end



def part_two input, rules
  pairs = Hash.new(0)
  input.chars.each_cons(2) { |x| pairs[x.join] += 1}
  
  40.times do 
    old_pairs = pairs.dup
    pairs = Hash.new(0)

    old_pairs.each do |pair, value|
      pairs[pair[0]+rules[pair]] += value
      pairs[rules[pair]+pair[1]] += value
    end
  end
  
  counts = Hash.new(0)
  pairs.each { |key, value| counts[key[0]] += value }
  counts[input[-1]] += 1
  minmax = counts.values.minmax
  (minmax[0] - minmax[1]).abs
end

p part_one input, rules
p part_two input, rules