#require 'profile'

input = File.read('25.input').split

card_public_key = input[0].to_i
door_public_key = input[1].to_i


def transform subject_number, loop_size

    value = 1
    
    loop_size.times do 
        value *= subject_number
        value %= 20201227
    end

    value
end

def find_loop_size public_key
    loop_size = 0
    val = 1
    loop do
        loop_size += 1
        val = (val * 7) % 20201227
        return loop_size if val == public_key
    end

    return nil
end

p card_public_key
p door_public_key

p card_loop_size = find_loop_size(card_public_key)
p door_loop_size = find_loop_size(door_public_key)

p transform(door_public_key, card_loop_size)
p transform(card_public_key, door_loop_size)