ALGO, input = File.read("20.input").split("\n\n")
PADDING = 50 
image = input.split("\n").map(&:chars)

image = image.each do |x| 
  PADDING.times { x << "." }
  PADDING.times { x.unshift(".") }
end

PADDING.times { image << ("." * image[0].size).chars }
PADDING.times { image.unshift ("." * image[0].size).chars }

def print image
  image.each { puts _1.join }
end

def peek image, x, y, new_x, new_y
  return image[x][y] if !(0...image.size).include?(new_x) || 
                        !(0...image[0].size ).include?(new_y) || 
                        image[new_x] == nil
  
  image[new_x][new_y]
end

def get_code image, x, y 
  (x-1..x+1).map do |new_x| 
    (y-1..y+1).map do |new_y| 
      peek(image, x, y, new_x, new_y) 
    end.join 
  end.join.gsub(".", "0").gsub("#", "1").to_i(2)
end

def new_image image

end

def mutate image
  new_image = Array.new(image.size) { Array.new(image[0].size) }

  (0...image.size).each do |x|
    (0...image[0].size).each do |y|
      code = get_code(image, x, y)
      new_image[x][y] = ALGO[code]
    end
  end
  
  return new_image
end

#print image
(1..PADDING).each do |x| 
  p x
  image = mutate(image)
end

p image.flatten.count { _1 == "#" }