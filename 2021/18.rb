require 'json'

def find_match source
  brackets = []
  source.chars.each.with_index do |char, index| 
    brackets << char if char == '['
    brackets.pop if char == ']'
    
    
    next_bracket = source[index..].index("]")
    result = [source[0...index], source[index..index+next_bracket], source[index+next_bracket+1..]] 
    return result if brackets.size == 5
  end
  []
end

def explode source 
  beggining, match, ending = find_match source
  return source if match == nil

  left, right = JSON.parse(match)
  ending = ending.sub(/(\d{1,2})/) { |match| match.to_i + right }
  beggining = beggining.sub(/(\d+)\D*$/) { |match| match.sub($1, "#{$1.to_i+left}")  }

  "#{beggining}0#{ending}" 
end

def split source
  replaced = false

  return source.gsub(/(\d{1,2})/) do |number| 
    number = number.to_i
    if number > 9 && !replaced
      replaced = true
      "[#{number/2},#{number/2+number%2}]"
    else
      number.to_s
    end
  end
end

def reduce source
  loop do
    break if source == explode(source)
    source = explode(source)
    #p "Explode: #{source}"
  end

  loop do 
    new_source = split(source)
    #p "Split: #{new_source}"
    new_source = explode(new_source)
    #p "Explode: #{new_source}"

    break if source == new_source
    source = new_source
  end  

  source
end

def sum sources
  number = sources[0]

  sources[1..].each do |new_number|
    number = "[#{number},#{new_number}]"
    number = reduce(number)
  end

  number
end

def test_explode source, expected
  actual = explode(source)

  puts "\nExplode: #{expected == actual}, source: #{source}, actual: #{actual}, expected: #{expected}" 
end 

def test_split source, expected
  actual = split(source)
  puts "\nSplit: #{expected == actual}, source: #{source}, actual: #{actual}, expected: #{expected}" 
end

def test_reduce source, expected
  actual = reduce(source)
  puts "\nReduce: #{expected == actual}, source: #{source}, actual: #{actual}, expected: #{expected}" 
end

def test_sum source, expected
  actual = sum(source.split)

  puts "\nSum: #{expected == actual}, source: #{source.split.join}, actual: #{actual}, expected: #{expected}" 
end

def test_mag source, expected
  actual = mag(source)

  puts "\nMag: #{expected == actual}, source: #{source.split.join}, actual: #{actual}, expected: #{expected}" 
end

def mag source
  eval(source.gsub("[", "(3*").gsub(",", "+2*").gsub("]", ")"))
end

puts "# Tests:"
test_explode "[[[[[9,8],1],2],3],4]", "[[[[0,9],2],3],4]"
test_explode "[7,[6,[5,[4,[3,2]]]]]", "[7,[6,[5,[7,0]]]]"
test_explode "[[6,[5,[4,[3,2]]]],1]", "[[6,[5,[7,0]]],3]"
test_explode "[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]", "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]"
test_explode "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]", "[[3,[2,[8,0]]],[9,[5,[7,0]]]]"
test_explode "[[[[0,[13,7]],[[7,7],[0,7]]],[[[8,7],[7,7]],[[8,8],[8,0]]]],[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]]", "[[[[13,0],[[14,7],[0,7]]],[[[8,7],[7,7]],[[8,8],[8,0]]]],[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]]"
test_explode "[[[[[6,7],14],[7,15]],[[14,15],[16,2]]],[[[0,11],[6,11]],[[10,10],[5,0]]]]", "[[[[0,21],[7,15]],[[14,15],[16,2]]],[[[0,11],[6,11]],[[10,10],[5,0]]]]"

test_split "[[[[0,7],4],[15,[0,13]]],[1,1]]", "[[[[0,7],4],[15,[0,13]]],[1,1]]"
test_split "[[[[13,14],[7,15]],[[14,15],[16,2]]],[[[0,11],[6,11]],[[10,10],[5,0]]]]", "[[[[[6,7],14],[7,15]],[[14,15],[16,2]]],[[[0,11],[6,11]],[[10,10],[5,0]]]]"
test_split "[[[[0,21],[7,15]],[[14,15],[16,2]]],[[[0,11],[6,11]],[[10,10],[5,0]]]]", "[[[[0,[10,11]],[7,15]],[[14,15],[16,2]]],[[[0,11],[6,11]],[[10,10],[5,0]]]]"
test_reduce "[[[[0,[13,7]],[[7,7],[0,7]]],[[[8,7],[7,7]],[[8,8],[8,0]]]],[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]]", "[[[[7,0],[7,7]],[[7,7],[7,8]]],[[[7,7],[8,8]],[[7,7],[8,7]]]]"

test_reduce "[[[[[6,6],[6,6]],[[6,0],[6,7]]],[[[7,7],[8,9]],[8,[8,1]]]],[2,9]]", "[[[[6,6],[7,7]],[[0,7],[7,7]]],[[[5,5],[5,6]],9]]"

reduce "[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]" 

reduce '[[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]]'

test_sum "[1,1]\n[2,2]\n[3,3]\n[4,4]", "[[[[1,1],[2,2]],[3,3]],[4,4]]"
test_sum "[1,1]\n[2,2]\n[3,3]\n[4,4]\n[5,5]", "[[[[3,0],[5,3]],[4,4]],[5,5]]"
test_sum "[1,1]\n[2,2]\n[3,3]\n[4,4]\n[5,5]\n[6,6]", "[[[[5,0],[7,4]],[5,5]],[6,6]]"

test_mag "[9,1]", 29
test_mag "[[1,2],[[3,4],5]]", 143
test_mag "[[[[1,1],[2,2]],[3,3]],[4,4]]", "445"

puts "\n# Actual - Part One: \n"

input = File.read("18.input").split("\n")

puts mag(sum(input))

puts "\n# Actual - Part Two: \n"

p input.permutation(2).to_a.map { |source| mag(sum(source)) }.max





