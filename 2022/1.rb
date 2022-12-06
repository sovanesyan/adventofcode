
l = File.read('1.input').split("\n\n").map { |x| x.split.map &:to_i}
                                      .map(&:sum)
                                      .sort

p l.last
p l.reverse.first(3).sum
