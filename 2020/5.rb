passes = File.read('5.input').split

ids = passes.map do |pass|
    row = pass[0, 7].gsub('B', '1').gsub('F', '0').to_i(2)
    column = pass [7, 3].gsub('R', '1').gsub('L', '0').to_i(2)
    row * 8 + column
end

p "Max: #{ids.max}, Min: #{ids.min}, Size: #{ids.size}" 
p ids.sort

p Range.new(ids.min, ids.max).filter { |x| !ids.include? x }