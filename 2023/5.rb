seeds = File.read('5.input').split("\n").first.split(':').last.scan(/\d+/).map(&:to_i)
puts "Seeds: #{seeds}"

mappings = File.read('5.input').split("\n\n")[1..].map { _1.split("\n")[1..].map { |x| x.scan(/\d+/).map(&:to_i)} }

final = seeds.map do |seed|
  result = seed
  mappings.each do |mapping|
    mapping.each do |destination, source, range|
      if result >= source && result < source + range
        result = destination + result - source 
        break
      end
    end
  end
  result
end

p final
p final.min

seeds = File.read('5.input').split("\n").first.split(':').last.scan(/\d+/).map(&:to_i).each_slice(2).to_a
p seeds

p seeds.map { [*(_1[0]...(_1[0] + _1[1]))]}.flatten.count