input = File.read('7.input').split("\n")
            

def process input 
    input.map do |x| 
        result = x.split(' contain ')
        result[0].gsub!(' bags', '')
        if result[1] == "no other bags."
            result[1] = nil 
        else
            result[1] = result[1].chop.split(', ').map do |y|
                result[1] = [y[0].to_i, y[1..].strip.gsub(' bags', '').gsub(' bag', '')]
            end
        end
        
        result 
    end.to_h
end

rules = process(input)

def count_colors(rules, search_for)
    return [] if search_for.size == 0
    
    result  = search_for.map do |bag| 
        valid_rules = rules.filter do |key, value|
            value != nil && value.any? { |x| x[1] == bag }
        end

        valid_rules.keys
    end.flatten.uniq
    p result

    result + count_colors(rules, result)
end

p count_colors(rules, ['shiny gold']).uniq.size

def count_size(rules, search_for)
    return 1 if rules[search_for] == nil
    result = rules[search_for].map do |bag|
        bag[0] * count_size(rules, bag[1])
    end.sum + 1

    p "#{search_for} contains #{result}"
    result
end

p count_size(rules, 'shiny gold') - 1 

