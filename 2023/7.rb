contents = File.read('7.input').split("\n").map(&:split)

p ranks = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'].each_with_index.map { [_1, ('A'.ord + _2).chr] }.to_h
p type_to_score = ['five_pair', 'four_pair', 'full_house', 'three_pair', 'two_pair', 'pair', 'high_card'].each_with_index.map { [_1, ('A'.ord + _2).chr] }.to_h

joker_ranks = ranks.dup
joker_ranks['J'] = 'Z'

hands = contents.map do |hand, bid|  
  grouped = hand.chars.group_by { _1 }.map { [_1, _2.size] }

  if grouped.filter { _2 == 5 }.first
    to_sort = type_to_score['five_pair'] 
  elsif grouped.filter { _2 == 4 }.first
    to_sort = type_to_score['four_pair'] 
  elsif grouped.filter { _2 == 3 }.first && grouped.filter { _2 == 2 }.first
    to_sort = type_to_score['full_house'] 
  elsif grouped.filter { _2 == 3 }.first 
    to_sort = type_to_score['three_pair'] 
  elsif grouped.filter { _2 == 2 }.size == 2
    to_sort = type_to_score['two_pair'] 
  elsif grouped.filter { _2 == 2 }.size == 1
    to_sort = type_to_score['pair'] 
  else  
    to_sort = type_to_score['high_card'] 
  end
  
  to_sort += hand.chars.map { ranks[_1] }.join

  [hand, bid, to_sort]
end

result = hands.
  sort_by { |_, _, score| score }.
  each_with_index.
  map do |hand, index| 
    hand, bid = hand
    bid.to_i * (hands.size - index)
  end


p result.sum


hands = contents.map do |old_hand, bid| 
  no_jokers = old_hand.chars-['J']

  joker_char = no_jokers.group_by { _1 }.map { [_1, _2.size] }.sort_by { |char, size| [-size, joker_ranks[char]] }.map(&:first).first
  hand = no_jokers.size == 5 ? old_hand : old_hand.gsub("J", joker_char || 'J')

  grouped = hand.chars.group_by { _1 }.map { [_1, _2.size] }
  if grouped.filter { _2 == 5 }.first
    to_sort = type_to_score['five_pair'] 
  elsif grouped.filter { _2 == 4 }.first
    to_sort = type_to_score['four_pair'] 
  elsif grouped.filter { _2 == 3 }.first && grouped.filter { _2 == 2 }.first
    to_sort = type_to_score['full_house'] 
  elsif grouped.filter { _2 == 3 }.first 
    to_sort = type_to_score['three_pair'] 
  elsif grouped.filter { _2 == 2 }.size == 2
    to_sort = type_to_score['two_pair'] 
  elsif grouped.filter { _2 == 2 }.size == 1
    to_sort = type_to_score['pair'] 
  else  
    to_sort = type_to_score['high_card'] 
  end

  to_sort += old_hand.chars.map { joker_ranks[_1] }.join

  [hand, bid, to_sort, old_hand]
end

result = hands.
  sort_by { |_, _, score| score }.
  each_with_index.
  map do |hand, index| 
    hand, bid = hand
    bid.to_i * (hands.size - index)
  end


p result.sum
