
games = File.read('2.input').split("\n")
  .map {[
    _1.split(":")[0].scan(/\d+/).map(&:to_i).first, 
    _1.split(":")[1].split(";").map { |x| { 
      :r => x.scan(/\d+ red/).first.to_i,
      :b => x.scan(/\d+ blue/).first.to_i,
      :g => x.scan(/\d+ green/).first.to_i, 
    }}
  ]}
  .to_h

bag = { :r => 12, :g => 13, :b => 14, }

p games.filter { |_, r| r.all? { |x| [:r, :b, :g].all? { x[_1] <= bag[_1]} }}.keys.sum
p games.map { |_, r| [:r, :g, :b].map { |c| r.map { _1[c] }.max }.reduce(:*) }.sum
  

  