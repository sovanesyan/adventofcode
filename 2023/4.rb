cards = File.read('4.input').split("\n")

p cards.
  map { |card| card.split(":").last.split("|").map { _1.scan(/\d+/).map(&:to_i) }.reduce(:&).length}.
  filter { _1 > 0 }.
  map { 2.pow(_1 - 1) }.
  sum

results = cards.map { [_1.split(":").first.scan(/\d+/).first.to_i, 1] }.to_h

cards.each do |card| 
  number, value = card.split(":")
  number = number.scan(/\d+/).map(&:to_i).first

  count = value.split("|").map { _1.scan(/\d+/).map(&:to_i) }.reduce(:&).length 
  if count > 0
     results[number].times do 
      (number+1).upto(number + count).each { results[_1] += 1 } 
     end
  end
end

p results.values.sum