input = File.read('15.input').split("\n")

sensors = input.map { _1.scan(/-?\d+/).map(&:to_i).each_slice(2).to_a }.to_h

def distance left, right
  left.zip(right).map { _1[0]-_1[1] }.map(&:abs).sum + 1
end

def boundries sensors
  sensors.map { [_1, distance(_1, _2)] }
         .map { [[_1[0]-_2, _1[0]+_2],[_1[1]-_2, _1[1]+_2]] }
         .transpose
         .map(&:flatten)
         .map(&:minmax)
         .flatten
end

def print sensors
  xmin, xmax, ymin, ymax = boundries sensors
  puts xmin.to_s.rjust(6)
  (ymin..ymax).each do |y|
    line = (xmin..xmax).map do |x| 
      res = "."
      res = "#" if sensors.any? { distance([x,y], _1) <= distance(_1, _2) }
      res = "S" if sensors.keys.include?([x,y])
      res = "B" if sensors.values.include?([x,y])
      res
    end.join
    
    puts "#{y.to_s.rjust(3)}: #{line}"
  end
end

def find_positions_on_line sensors, y
  xmin, xmax, _, _ = boundries sensors

  (xmin..xmax).select { |x| sensors.any? { distance([x,y], _1) <= distance(_1, _2)}}
              .map { |x| [x,y] }
end


def find_beakon sensors, real_boundry
  p "started finding corners"
  possible_beakons = sensors.map { [_1, distance(_1, _2)] }
                            .map do |sensor, dist|
                              xmin, xmax, ymin, ymax = [sensor[0]-dist, sensor[0]+dist, sensor[1]-dist, sensor[1]+dist]

                              res = []
                              x, y = xmin, sensor[1]
                              (res << [x,y]; x += 1; y -= 1) while y >= ymin
                              x, y = xmax, sensor[1]
                              (res << [x,y]; x -= 1; y += 1) while y <= ymax
                              x, y = sensor[0], ymin
                              (res << [x,y]; x += 1; y += 1) while x <= xmax
                              x, y = sensor[0], ymax
                              (res << [x,y]; x -= 1; y -= 1) while x >= xmin

                              p "finished corners for #{sensor} with distance: #{dist}"
                              res.reject

                            end.flatten(1)
  p "finished finding corners. #{possible_beakons.size}"
  p "bohos"
  possible_beakons.uniq!.select! { |x| x.all? { _1 >= 0 && _1 <= real_boundry} }
  p "unique corners in real #{possible_beakons.size}"
  beakon = possible_beakons.find { |coords| sensors.all? { |sensor, beakon| distance(coords, sensor) > distance(sensor, beakon) }}

  beakon.first * 4000000 + beakon.last
end

# print sensors

# positions = find_positions_on_line(sensors, 10) 
# puts (positions - sensors.values).size
# puts find_beakon(sensors, 20)

# positions = find_positions_on_line(sensors, 2000000) 
# puts (positions - sensors.values).size
puts find_beakon(sensors, 4000000)
