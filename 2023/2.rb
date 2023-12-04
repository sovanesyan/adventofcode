
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

filtered = games.
  filter do |game, reveal| 
    reveal.all? do |x| 
      [:r, :b, :g].all? { |color| x[color] <= bag[color]}
    end
  end

p filtered.keys.sum

powers = games.map do |game, reveals|
  [:r, :g, :b].map { |color| reveals.map { _1[color] }.max }.reduce(:*)
end

p powers.sum
  