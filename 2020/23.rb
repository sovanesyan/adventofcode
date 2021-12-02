require 'profile'
class Node
    attr_accessor :value, :next

    def initialize(value, next_node)
        @value = value
        @next = next_node
    end

    def to_s 
        "Node: #{value} => #{@next.value}"
    end

end

input = File.read('23.input')

def game cups, moves, print
    size = cups.size
    
    1.upto(moves).each do |move|
        current = (move - 1) % (cups.size)
        picked_up = (current+1...current+4).map { |index| cups[index % cups.size] } 
        

        destination = cups[current]
        loop do
            destination -= 1
            destination = cups.max if destination == 0
            break unless picked_up.include? destination  
        end
        
        if print
            puts "\n"
            puts "-- move #{move} --"
            puts "cups: #{cups.map.with_index { |x, index| index == current ? "(#{x})" : x }.join(" ")}"
            puts "pick up: #{picked_up.join(", ")}"
            puts "destination: #{destination}"
        else
            puts "move: #{move} out of #{moves}" if move % 100 == 0
        end

        current_value = cups[current]
        (current+1...current+4).map { |index| index % size }.to_a.sort.reverse
                               .each { |index| cups.delete_at(index % size) }

        cups.insert(cups.index(destination)+1, picked_up[0], picked_up[1], picked_up[2])
        
        10.times do 
            break if cups[current] == current_value
            cups << cups.shift
        end
    end

    puts "\n"
    puts "-- final --"

    cups
end

def print current  
    start = current
    result = ""
    
    loop do 
        result += " #{current.value}" 
        current = current.next
        
        break if current == start || current == nil
    end

    puts result

end

def linked_game cups, moves, print
    max = cups.max
    first = Node.new(cups.first, nil)
    destinations = Array.new(cups.size)
    destinations[first.value] = first
    current = first
    cups[1..].each do |cup| 
        current.next = Node.new(cup, nil)
        current = current.next
        destinations[cup] = current
    end
    current.next = first

    current = first
    
    moves.times do
        picked_up = current.next 
        current.next = picked_up.next.next.next
        picked_up.next.next.next = nil

        destination = current.value
        loop do
            destination -= 1
            destination = max if destination == 0
            break unless picked_up.value == destination || 
                         picked_up.next.value == destination || 
                         picked_up.next.next.value == destination
        end

        
        new_iterator = destinations[destination]
        new_next = new_iterator.next
        new_iterator.next = picked_up
        picked_up.next.next.next = new_next

        current = current.next
    end

    destinations[1]
end

#cups = linked_game(input.chars.map(&:to_i), 100, true)
#twice = cups * 2
#puts "result: #{twice[twice.index(1)+1, twice.size/2-1].join}"

start = Time.now
cups = Array.new(1000000) { |i| i+1 }
input.chars.map(&:to_i).each_with_index { |x, index| cups[index] = x }

one = linked_game(cups, 10000000, false)

puts (one.next.value * one.next.next.value)
finish = Time.now

puts "Elapsed #{finish-start} seconds"
