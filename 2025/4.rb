input = File.read('4.input').split("\n").map(&:chars)

def print_grid(grid, forklifts = [])
  puts "--------------------------------"
  p "Removed #{forklifts.size} paper rolls" 
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      print forklifts.include?([x, y]) ? 'X' : cell
    end
    puts
  end
end

def indexes(grid) = (0...grid[0].size).to_a.product((0...grid.size).to_a)
def surrounding(x, y, grid) = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].map { |dx, dy| [x + dx, y + dy] }.filter { |x, y| x >= 0 && y >= 0 && x < grid.size && y < grid[0].size }
def paper_rolls(x, y, grid) = surrounding(x, y, grid).count { |x, y| grid[y][x] == '@' }
def forklifts(grid) = indexes(grid).select { |x, y| grid[y][x] == '@' && paper_rolls(x, y, grid) < 4 }

forklifts = forklifts(input)
#print_grid input, forklifts
p forklifts.size


roll_count = input.flatten.count('@')
loop do
  lifts = forklifts(input)
  break if lifts.empty?
  lifts.each { |x, y| input[y][x] = '.' }

  #print_grid input, lifts
end

#print_grid input
puts roll_count - input.flatten.count('@')


