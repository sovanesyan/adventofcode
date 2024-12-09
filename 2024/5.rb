rules, updates = File.read('5.input').split("\n\n").map(&:split)

rules = rules.map { _1.split('|').map(&:to_i) }.group_by(&:first).
              transform_values { _1.map(&:last) }

updates = updates.map { _1.split(',').map(&:to_i) }

def sort(update, rules) = update.sort { |a, b| rules[a].include?(b) ? -1 : rules[b].include?(a) ? 1 : 0 }

correct = updates.select { _1 == sort(_1, rules) }

pp correct.map { _1[_1.length/2] }.sum
pp (updates - correct).map { sort(_1, rules) }.map { _1[_1.length/2] }.sum