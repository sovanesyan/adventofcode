l = File.read('1.input').split.map &:to_i

p l.zip(l[1..]).count{_1<(_2||0)}

l = l.each_with_index.map { |x, i| l[i + 2] == nil ? 0 : x + l[i + 1] + l[i + 2] }

p l.zip(l[1..]).count{_1<(_2||0)}