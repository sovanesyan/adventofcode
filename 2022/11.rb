monkeys = File.read('11.input').split("\n\n")

monkeys = monkeys.map do |raw|
  raw = raw.split("\n")
  
  id = raw[0].scan(/\d+/)[0].to_i
  items = raw[1][18..].split(',').map(&:to_i)
  operation = raw[2][19..]
  test = raw[3][21..].to_i
  test_true = raw[4].scan(/\d+/)[0].to_i
  test_false = raw[5].scan(/\d+/)[0].to_i
  
  [id, { 
    items:, 
    operation:,
    test:,
    test_true:,
    test_false:,
  }]
end.to_h

# inspections = monkeys.keys.map { 0 }
# 20.times do 
#   monkeys.each do |id, monkey|
    
#     monkey[:items].each do |item|
#       inspections[id] += 1
#       new_item = eval(monkey[:operation].gsub('old', item.to_s)) / 3
#       if new_item % monkey[:test] == 0
#         monkeys[monkey[:test_true]][:items].push(new_item)
#       else
#         monkeys[monkey[:test_false]][:items].push(new_item)
#       end
#     end
#     monkey[:items] = []
#   end

#   monkeys.each do |id, monkey|
#     #p "Monkey #{id}: #{monkey[:items]}"
#   end
# end
# p inspections.sort.last(2).reduce(&:*)

inspections = monkeys.keys.map { 0 }
p modulo = monkeys.values.map { _1[:test] }.reduce(&:*)
10000.times do |iter|
  monkeys.each do |id, monkey|
    
    monkey[:items].each do |item|
      inspections[id] += 1
      new_item = eval(monkey[:operation].gsub('old', item.to_s)) % modulo
      if new_item % monkey[:test] == 0
        monkeys[monkey[:test_true]][:items].push(new_item)
      else
        monkeys[monkey[:test_false]][:items].push(new_item)
      end
    end
    monkey[:items] = []
  end
  p "#{iter}: #{inspections}"
end
p inspections.sort.last(2).reduce(&:*)