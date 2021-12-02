input = File.read('3.input').split("\n")
            .map do |x| 
                left, right =  x.split("@")[1].split(":")
                {
                    :id => x.split("@")[0],
                    :left => left.split(",")[0].to_i,
                    :top => left.split(",")[1].to_i,
                    :wide => right.split("x")[0].to_i,
                    :tall => right.split("x")[1].to_i
                }
            end
fabric = Hash.new(0)

input.each do |x|
    (x[:left]...(x[:left]+x[:wide])).each do |x_axis|
        (x[:top]...(x[:top]+x[:tall])).each do |y_axis|
           fabric["#{x_axis}:#{y_axis}"] += 1 
        end
    end
end

p fabric.select { |key, value| value >= 2 }.count

input.each do |x|
    overlaps = false
    
    (x[:left]...(x[:left]+x[:wide])).each do |x_axis|
        (x[:top]...(x[:top]+x[:tall])).each do |y_axis|
           overlaps ||= fabric["#{x_axis}:#{y_axis}"] > 1
        end
    end

    puts x unless overlaps
end