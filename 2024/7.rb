input = File.read('7.input').split("\n").map { _1.split(':') }.
            map { [_1[0].to_i, _1[1].scan(/(\d+)/).map(&:first).map(&:to_i)] }

res = input.select do |result, params| 
  ["*", "+"].repeated_permutation(params.size-1).any? do |ops|
    result == params.inject { eval("#{_1}#{ops.shift}#{_2}") }
  end
end

pp res.map(&:first).sum

res = input.select do |result, params| 
  ["*", "+", ""].repeated_permutation(params.size-1).any? do |ops|
    result == params.inject { eval("#{_1}#{ops.shift}#{_2}") }
  end
end

pp res.map(&:first).sum