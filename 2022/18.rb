require 'matrix'
require 'set'

all_cubes = File.read('18.input').split("\n").map { _1.split(",").map(&:to_i)}.to_set

sides = all_cubes.map { |cube| 6 - (all_cubes-[cube]).count { (Vector[*cube] - Vector[*_1]).map(&:abs).sum.abs == 1 } }

p "Part 1: #{sides.sum}"

# def included_in? array, value
#   value.between?(*array) && !array.include?(value)
# end

# p all_cubes.size
# all_cubes.reject! do |cube| 
#   other_cubes = all_cubes-[cube]
#   included_in?(other_cubes.map(&:first).minmax, cube[0]) &&
#   included_in?(other_cubes.map{ _1[1] }.minmax, cube[1]) && 
#   included_in?(other_cubes.map(&:last).minmax, cube[2])
# end

sides = all_cubes.map { |cube| 6 - (all_cubes-[cube]).count { (Vector[*cube] - Vector[*_1]).map(&:abs).sum.abs == 1 } }

p "Part 2: #{sides.sum}"
