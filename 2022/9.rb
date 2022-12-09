motions = File.read('9.input').split("\n").map(&:split)
DIRECTIONS = { "R" => [0, 1], "L" => [0, -1], "U" => [1, 0], "D" => [-1, 0] }
CORNERS = { "RU" => [1, 1], "RL" => [1, -1], "DU" => [-1, 1], "DL" => [-1, -1] }

def add(a, b) = a.zip(b).map(&:sum)
def distant?(head, tail) = (head[0]-tail[0]).abs > 1 ||  (head[1]-tail[1]).abs > 1 || (head[0]-tail[0]).abs + (head[1]-tail[1]).abs > 2
def same_line(head, tail) = head[0] == tail[0] || head[1] == tail[1]

def solve motions, rope
  tails = [[0, 0]]

  motions.each do |direction, steps|
    steps.to_i.times do 
      rope["H"] = add(rope["H"], DIRECTIONS[direction])
      rope.keys.each_cons(2) do |head, tail|
        if distant?(rope[head], rope[tail])
          possible_directions = same_line(rope[head], rope[tail]) ? DIRECTIONS.values : CORNERS.values
          rope[tail] = possible_directions.map { add(rope[tail], _1) }
                                          .select { !distant?(rope[head], _1) }.first
        end
      end

      tails << rope["9"]
    end
  end
  p tails.uniq.size
end

rope = {}
rope["H"] = [0, 0]
rope["9"] = [0, 0]
solve(motions, rope)

rope = {}
rope["H"] = [0, 0]
(1..9).each { |x| rope[x.to_s] = [0, 0]}
solve(motions, rope)
