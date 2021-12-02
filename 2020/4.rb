
def key_is_valid?(x) 
    key, value = x

    case key
    when 'byr'
        value.to_i.between?(1920, 2002)
    when 'iyr'
        value.to_i.between?(2010, 2020)
    when 'eyr'
        value.to_i.between?(2020, 2030)
    when 'hgt'
        if value.end_with?('cm')
            value.chomp('cm').to_i.between?(150, 193)
        else 
            value.end_with?('in') && value.chomp('in').to_i.between?(59, 76)
        end
    when 'hcl'
        value =~ /^#([A-Fa-f0-9]{6})$/i
    when 'ecl'
        ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include? value
    when 'pid'
        value =~ /([0-9]{9})$/i && value.size == 9
    when 'cid'
        true
    end
end

def is_valid?(passport)
    required_keys = [
        'byr',
        'iyr',
        'eyr',
        'hgt',
        'hcl',
        'ecl',
        'pid'
    ]

    data = Hash[passport.split.map { |x| x.split(':') }]
    
    (data.keys & required_keys).size == required_keys.size && 
    data.all? { |x| key_is_valid?(x) }
end

map =  File.read('4.input').split("\n\n")

valid_passports = map.select { |passport| is_valid?(passport) }

p valid_passports.count
