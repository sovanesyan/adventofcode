input = File.read('13.input').split

busses = input[1].split(',')
                    .map { |x| x }


def extended_gcd(a, b)
    last_remainder, remainder = a.abs, b.abs
    x, last_x, y, last_y = 0, 1, 1, 0
    while remainder != 0
      last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
      x, last_x = last_x - quotient*x, x
      y, last_y = last_y - quotient*y, y
    end
    return last_remainder, last_x * (a < 0 ? -1 : 1)
  end
   
  def invmod(e, et)
    g, x = extended_gcd(e, et)
    if g != 1
      raise 'Multiplicative inverse modulo does not exist!'
    end
    x % et
  end
   
  def chinese_remainder(mods, remainders)
    max = mods.inject( :* )  # product of all moduli
    series = remainders.zip(mods).map{ |r,m| (r * max * invmod(max/m, m) / m) }
    series.inject( :+ ) % max 
  end
  
mods, remainders = [], []

busses.each.with_index do |x, i| 
    next if x == 'x'
    mods << x.to_i
    remainders << x.to_i - i
end
p mods
p remainders
p chinese_remainder(mods, remainders)