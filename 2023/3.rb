contents = File.read('3.input')
line_size = contents.split("\n").first.length
lines = contents.split("\n").length

contents.gsub!("\n", '')


contents = contents.enum_for(:scan, /\d+/).map do |number|
  start = Regexp.last_match.begin(0) 
  
  xmin, xmax = [[start-1, 0].max, [start + number.length, contents.length].min]
  xbeforemin, xbeforemax = [[xmin-line_size, 0].max, [xmax-line_size, 0].max]
  xaftermin, xaftermax = [[xmin+line_size, contents.length].min, [xmax+line_size, contents.length].min]

  [*(xmin..xmax), *(xbeforemin..xbeforemax), *(xaftermin..xaftermax)].uniq.
    filter { "#{contents[_1]}".match?(/[^a-z.A-Z\d]/)}.
    map { [[contents[_1], _1], number]}.
    flatten(1)
    
end.filter { _1.length > 0 }

p contents.map { _1.last.to_i }.sum

p contents.
  filter { _1.first.first == '*' }.
  group_by { _1.first.last }.
  filter { _2.length > 1 }.
  map { _2.map { |x| x.last.to_i }.inject(:*) }.
  sum
  