input = File.read("5.input").split("\n")


clouds = input.map do |x| 
    x.split("->").map { |x| x.split(",").map { _1.to_i }}.flatten
end

diagram = Hash.new(0)

clouds.each do |x1, y1, x2, y2|
    len = [x1-x2, y1-y2].map { _1.abs }.max + 1
    xs = x1 == x2 ? [x1] * len : x1.step(by: x1 < x2 ? 1: -1, to: x2)
    ys = y1 == y2 ? [y1] * len : y1.step(by: y1 < y2 ? 1: -1, to: y2)

    xs.zip(ys).each do |point|
        diagram["#{point[0]}:#{point[1]}"] += 1
    end
end

p diagram.select { |key, value| value >= 2 }.count