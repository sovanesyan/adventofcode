require 'Set'
require 'JSON'

input = File.read("19.input").split("\n\n")

def distance(p, q)
  p, q = [p].flatten, [q].flatten
  Math.sqrt(p.zip(q).inject(0){ |sum, coord| sum + (coord.first - coord.last)**2 })
end 

def distances(scanner, point)
  (scanner-[point]).map { |other| distance(point, other) }
end

scanners = input.map { _1.split("\n")[1..].map { |x| x.split(",").map(&:to_i)} }
scanners = scanners.map.with_index { |x, i| [x, i] }

mapped_scanners = Hash.new { |hash, key| hash[key] = Set.new }


scanners.each do |scanner, index|
  scanner.each do |point|
    distances = distances(scanner, point)

    (scanners - [scanner]).each do |other_scanner, other_index|
      other_scanner.each do |other_point|
        other_distances = distances(other_scanner, other_point)
        size = (other_distances.intersection(distances)).size
        if size == 11
          mapped_scanners[index] << other_index
        end
      end
    end
  end
end
mapped_scanners.each { |key, value| p "#{key.to_s}: #{value}"}