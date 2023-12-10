contents = File.read('6.input')

p times = contents.split("\n").first.scan(/\d+/).map(&:to_i)
p records = contents.split("\n").last.scan(/\d+/).map(&:to_i)

# Part 1

res = (0...times.length).map do |i|
  duration = times[i]
  (0..duration).filter { |hold| hold * (duration - hold) > records[i] }.count
end

p res.inject(:*)

# Part 2
contents = File.read('6.input').gsub(' ', '')

p times = contents.split("\n").first.scan(/\d+/).map(&:to_i)
p records = contents.split("\n").last.scan(/\d+/).map(&:to_i)

res = (0...times.length).map do |i|
  duration = times[i]
  (0..duration).filter { |hold| hold * (duration - hold) > records[i] }.count
end

p res.inject(:*)