l = File.read('2.input').lines
MAPPER = {
    "A" => 1,
    "B" => 2,
    "C" => 3,
    "X" => 1,
    "Y" => 2,
    "Z" => 3,
}

WINNER = { 
    1 => 3,
    2 => 1,
    3 => 2
}

LOSER = { 
    1 => 2,
    2 => 3,
    3 => 1,
}

def calculate l 
    result = l.map do |x| 
        res = x[1]
        if x[1] == x[0]
            res += 3 
        else
            res += WINNER[x[1]] == x[0] ? 6 : 0
        end
    
        res
    end
    result.sum
end

l = l.map { |x| x.split.map{ |x| MAPPER[x]}}
p calculate(l)
second = l.map do |x| 
    case x[1]
    when 1 
        x[1] = WINNER[x[0]]
    when 2 
        x[1] = x[0] 
    when 3 
        x[1] = LOSER[x[0]] 
    end
    
    x
end
p calculate(second)

