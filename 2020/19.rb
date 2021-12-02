rules, messages = File.read('19.input').split("\n\n")
p rules = rules.split("\n").map { |x| x.split(": ") } .to_h



def parse_regex rules, index
    rule = rules[index]
    result = nil

    if rule.include? ("\"")
        result = rule.delete("\"") 
    elsif rule.include?("8") && index == "8"
        result = "#{parse_regex(rules, "42")}+"
    elsif rule.include?("11") && index == "11"
        result = "(?<e>#{parse_regex(rules, "42")} \\g<e>* #{parse_regex(rules, "31")})+"
    else
        result = rule.split('|').map do |sub_rule|
            sub_rule.split(" ").map do |x| 
                    parse_regex(rules, x)
            end.join
        end.join("|")

        result = "(#{result})"
    end

    return result
end

p regex = parse_regex(rules, "0")
p count = messages.split("\n").filter { |msg| msg.match "^#{regex}$" }.count

#rules["8"] = "42 | 42 42 | 42 42 42 | 42 42 42 42 | 42 42 42 42 42 | 42 42 42 42 42 42 | 42 42 42 42 42 42 42 | 42 42 42 42 42 42 42 42 | 42 42 42 42 42 42 42 42 42 | 42 42 42 42 42 42 42 42 42 42 | 42 42 42 42 42 42 42 42 42 42 42"
rules["8"] = "42 | 42 8"
rules["11"] = "42 31 | 42 11 31"

#rules["11"] = "42 31 | 42 42 31 31 | 42 42 42 42 31 31 31 31 | 42 42 42 42 42 31 31 31 31 31 | 42 42 42 42 42 42 31 31 31 31 31 31 | 42 42 42 42 42 42 42 31 31 31 31 31 31 31 | 42 42 42 42 42 42 42 42 31 31 31 31 31 31 31 31 | 42 42 42 42 42 42 42 42 42 31 31 31 31 31 31 31 31 31 | 42 42 42 42 42 42 42 42 42 42 31 31 31 31 31 31 31 31 31 31 | 42 42 42 42 42 42 42 42 42 42 42 31 31 31 31 31 31 31 31 31 31 31"

p regex = parse_regex(rules, "0")
#count = messages.split("\n").each { |msg| p msg if msg.match "^#{regex}$" }
p count = messages.split("\n").filter { |msg| msg.match "^#{regex}$" }.count
