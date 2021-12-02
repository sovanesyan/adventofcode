valid = File.open('2.input').filter do |line|
    rule, password = line.split(":")
    rule, character = rule.split
    first, second = rule.split('-').map { |x| x.to_i }

    (password[first] == character) ^ (password[second] == character)
end

p valid.count
