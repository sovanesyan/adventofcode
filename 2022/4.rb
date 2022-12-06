l = File.read('4.input').split

l = l.map do |x|
    x.split(',')
     .map{|y| y.split('-')}
     .map{|y| Range.new(y[0], y[1]).to_a}
end

p l.count { |x, y| (x-y).empty? || (y-x).empty? }
p l.count { |x, y| (x&y).any? }