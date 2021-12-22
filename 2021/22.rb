input = File.read("22.input.test").split("\n")

cubes = {}

input.each do |command|
  toggle, coords = command.split(" ")
  toggle = toggle == "on"

  x,y,z = coords.split(",").map { |x| x.split("=")[1].split("..").map(&:to_i) }
  x[0] = x[0] < -50 ? -50 : x[0]
  y[0] = y[0] < -50 ? -50 : y[0]
  z[0] = z[0] < -50 ? -50 : z[0]

  x[1] = x[1] > 50 ? 50 : x[1]
  y[1] = y[1] > 50 ? 50 : y[1]
  z[1] = z[1] > 50 ? 50 : z[1]
  
  (x[0]..x[1]).each do |x|
    (y[0]..y[1]).each do |y|
      (z[0]..z[1]).each do |z|
        cubes[[x,y,z]] = toggle
      end
    end
  end
end
p cubes.select { |key, value| value }.count