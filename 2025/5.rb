fresh, ingredients = File.read('5.input').split("\n\n").map { _1.split("\n") }

fresh = fresh.map { Range.new(*_1.split('-').map(&:to_i)) }

p ingredients.map(&:to_i).count { |ingredient| fresh.any? { _1.include? ingredient } }

sorted = fresh.sort_by(&:begin)
merged = [sorted.first]

sorted.each do |range|
  if range.begin > merged.last.end
    merged << range.dup
  else
    merged[-1] = (merged.last.begin..[merged.last.end, range.end].max)
  end
end

p merged.map(&:size).sum
