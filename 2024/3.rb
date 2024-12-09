input = File.read("3.input").delete("\n")

def solve(input) = input.scan(/mul\(\d+,\d+\)/).map { _1.scan(/\d+/).map(&:to_i).reduce(:*) }.sum

puts solve(input) 
puts solve(input.gsub(/don't\(\)(.*?)do\(\)/, '').gsub(/don't\(\)(.*)\)/, ''))