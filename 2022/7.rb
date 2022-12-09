commands = File.read('7.input').split('$').reject(&:empty?).map(&:strip)

file_system = { '/' => {}}
current = []
commands.each do |command|
    lines = command.split("\n")
    if lines[0] == 'cd /'
        current = ['/']
    elsif lines[0] == "cd .."
        current.pop
    elsif lines[0].start_with?('cd')
        dir = lines[0].split[1]
        current << dir
    elsif lines[0] == 'ls'
        lines[1..].each do |output|
            current_dir = file_system.dig(*current)
            x, y = output.split
            current_dir[y] = x == 'dir' ? {} : x
        end
        
    end
    file_system
end

dir_sizes = {}

def search(fs, current, dir_sizes)
    current_dir = fs.dig(*current)
    total = 0
    
    current_dir.each do |key, value|
        total += value.is_a?(Hash) ? search(fs, current.dup.push(key), dir_sizes) : value.to_i
    end

    dir_sizes[current.join] = total
    total
end

total = search(file_system, ['/'], dir_sizes)
p dir_sizes.values.reject{|x| x > 100000}.sum
free_space = 70000000 - dir_sizes.values.max
required_space = 30000000 - free_space
p required_space
p dir_sizes.values.select { |x| x > required_space }.sort.first