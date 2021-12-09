input = File.read("6.input").split(",").map(&:to_i)

def solve input, days
  fish = input.tally
  fish.default = 0

    days.times do
        fish.transform_keys! {|days| days - 1 }
        fish[8] = fish[-1]
        fish[6] += fish[-1]
        fish.delete(-1)
    end
    
    fish.values.sum
end

p solve input, 80
p solve input, 256