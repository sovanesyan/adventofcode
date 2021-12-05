def bingo?(board)
    return board.any? { |row| row.all? { _1 == "x"} }
end

def problem1(numbers_to_draw, boards)
    numbers_to_draw.each do |drawn_number|
        boards.each do |board|
            board.each { |row| row.map! { |number| number == drawn_number ? "x" : number } }

            if bingo?(board) || bingo?(board.transpose)
                return drawn_number * board.flatten.select { _1 != "x"}.sum 
            end
        end    
    end
end

def problem2(numbers_to_draw, boards)
    winners = []
    last_winner = 0

    numbers_to_draw.each do |drawn_number|
        boards.each do |board|
            board.each { |row| row.map! { |number| number == drawn_number ? "x" : number } }

            if !winners.include?(board) && (bingo?(board) || bingo?(board.transpose))
                winners << board
                last_winner = drawn_number * board.flatten.select { _1 != "x"}.sum 
            end
        end    
    end

    return last_winner
end

input = File.read("4.input.test").split("\n\n")

numbers_to_draw = input[0].split(",").map(&:to_i)
boards = input[1..].map { |x| x.split("\n").map { _1.split.map(&:to_i) } }

p problem1(numbers_to_draw, boards)
p problem2(numbers_to_draw, boards)