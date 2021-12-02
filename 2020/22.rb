input = File.read('22.input')
input = input.split("\n\n").map { |x| x.split("\n")[1..].map { |y| y.to_i }}

p deck1 = input[0]
p deck2 = input[1]

def calculate deck
    deck.reverse.map.with_index { |x, index| x * (index + 1) }.sum
end

def part1 deck1, deck2
    round = 1
    loop do
        puts "\n"
        puts "--- Round #{round} ---"
        puts "Player 1's deck: #{deck1.join(', ')}"
        puts "Player 2's deck: #{deck2.join(', ')}"
        first = deck1.shift
        second = deck2.shift
        puts "Player 1 plays: #{first}"
        puts "Player 2 plays: #{second}"
        puts "#{first > second ? "Player 1" : "Player 2"} wins the round"
        if first > second
            deck1 << first << second
        else
            deck2 << second << first
        end
        round += 1

        break if deck1.empty? || deck2.empty?
    end

    puts "\n"
    puts "== Post-game resulsts =="
    puts "Player 1's deck: #{deck1.join(', ')}"
    puts "Player 2's deck: #{deck2.join(', ')}"

    p calculate [deck1 + deck2].flatten
end


def game deck1, deck2, games
    games.push << "game"
    round = 1
    previous_rounds = []
    game_number = games.size
    loop do
        round_hash = calculate(deck1) * calculate(deck2)
        
        puts "\n"
        puts "--- Round #{round}: Game #{game_number} ---"
        puts "Player 1's deck: #{deck1.join(', ')}"
        puts "Player 2's deck: #{deck2.join(', ')}"
        first = deck1.shift
        second = deck2.shift
        puts "Player 1 plays: #{first}"
        puts "Player 2 plays: #{second}"
        
        if deck1.size >= first && deck2.size >= second
            if game(deck1.first(first), deck2.first(second), games)
                deck1 << first << second
            else
                deck2 << second << first
            end
        else
            puts "#{first > second ? "Player 1" : "Player 2"} wins the round"
            if first > second
                deck1 << first << second
            else
                deck2 << second << first
            end
        end
        
        round += 1

        return true if deck2.empty? || previous_rounds.include?(round_hash)
        return false if deck1.empty?
        previous_rounds << round_hash
    end
end

games = []
game deck1, deck2, games

puts "\n"
puts "== Post-game resulsts =="
puts "Player 1's deck: #{deck1.join(', ')}"
puts "Player 2's deck: #{deck2.join(', ')}"
p calculate [deck1 + deck2].flatten