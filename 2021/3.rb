input = File.read("3.input").split

gamma = input.map(&:chars).transpose.map do |x|
  x.group_by(&:itself).values.max_by(&:size).first
end.join.to_i(2)

epsilon = input.map(&:chars).transpose.map do |x|
    x.group_by(&:itself).values.min_by(&:size).first
end.join.to_i(2)

p gamma * epsilon

oxygen = File.read("3.input").split
(0...oxygen[1].size).each do |i|
    break if oxygen.size == 1
    x = oxygen.map {_1[i]}
    digit = x.group_by(&:itself)["1"].size >= x.group_by(&:itself)["0"].size ? "1" : "0"
    oxygen.select! { |x| x[i] == digit }
end

cotwo = File.read("3.input").split
(0...cotwo[1].size).each do |i|
    break if cotwo.size == 1
    x = cotwo.map {_1[i]}
    
    digit = x.group_by(&:itself)["1"].size < x.group_by(&:itself)["0"].size ? "1" : "0"
    cotwo.select! { |x| x[i] == digit } unless cotwo.size == 1
end

p (oxygen + cotwo).map { _1.to_i(2) }.inject(:*)
