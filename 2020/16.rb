input = File.read('16.input').split("\n\n")
rules = {}
input.first.split("\n").each do |line|
    rule, details = line.split(": ")
    rules[rule] = details.split(" or ").map { |x| x.split("-").map { |y| y.to_i } }
end
my_ticket = input[1].split("\n")[1].split(",").map { |y| y.to_i } 
nearby_tickets = input[2].split("\n")[1..].map { |x| x.split(",").map { |y| y.to_i } }

def part_one nearby_tickets, rules
    errors = nearby_tickets.flatten.filter do |number|
        rules.values.flatten(1).all? do |value|
            !number.between?(value[0], value[1])
        end
    end

    p errors.sum
end

valid_tickets = nearby_tickets.filter do |ticket|
    ticket.all? do |number|
        rules.values.flatten(1).any? do |value|
            number.between?(value[0], value[1])
        end
    end
end

all_tickets = valid_tickets + [my_ticket]

possible_perms = {}
(0...all_tickets.first.size).each do |index|
    valid_rules = rules.filter do |rule_key, value|
        all_tickets.all? do |ticket|
            value.any? do |rule|
                ticket[index].between? rule[0], rule[1]
            end
        end
    end

    possible_perms[index] = valid_rules.keys
end

fixed_keys = []
loop do 
    possible_perms.each do |index, keys|
        next if keys.size > 1 || fixed_keys.include?(keys.first)

        fixed_keys << keys.first
        possible_perms.each do |possible_perm|
            possible_perm[1].delete(keys.first) if possible_perm[0] != index
        end

        break;
    end

    break if possible_perms.all? { |index, keys| keys.size == 1 }
end

p possible_perms.invert.filter { |key, index| key.first.start_with? "departure" }
                       .map { |key, index| my_ticket[index] }
                       .inject (:*)
#p size = rules.keys.permutation.size
# rules.keys.permutation.each.with_index do |perm, index| 
#     p "#{index} of #{size}: #{perm}"
#     valid = true
#     perm.each.with_index do |rule_key, index|
#         valid &= all_tickets.all? do |ticket|
#             rules[rule_key].any? do |rule|
#                 ticket[index].between? rule[0], rule[1]
#             end
#         end
#         break unless valid
#     end

#     if valid
#         p perm
#         break;
#     end
# end