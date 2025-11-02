notes = File.read('13.input').split("\n\n").map { _1.split("\n").map(&:chars) }

def print note
  puts "\n"
  note.each_with_index.each { puts "#{_2.to_s.rjust(3)}: #{_1.join}" }
end

def solve note
  # print note
  note.each_with_index do |row, i|
    next if i == 0 || i == note.size - 1
    # p [i, note.size - i ]
    len = [i, note.size - i - 1].min
    # puts "------- index: #{i} len: #{len} size: #{note.size} -------"
    relevant_note = note[i-len...i+len]
    # print relevant_note if relevant_note[0...relevant_note.size/2] == relevant_note[relevant_note.size/2..].reverse
    
    if relevant_note[0...relevant_note.size/2] == relevant_note[relevant_note.size/2..].reverse
      p i -1 
      return i - 1 
    end
    
  end

  nil
end

p notes.map { solve(_1.transpose) || 100 * solve(_1) }.sum