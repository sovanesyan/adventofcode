input = File.read("16.input")

binary = [input].pack("H*").unpack("B*")[0]

class Packet
  def initialize binary
    @binary = binary
    @version = binary[0..2].to_i(2)
    @type_id = binary[3..5].to_i(2)
    @contents = binary[6..].chars
    @packets = []
    @lengths = ""
    @laterals = []
    
    if @type_id == 4 # lateral
      slices = @contents.each_slice(5).to_a
      @laterals =  slices.take_while { |x| x[0] != "0" }
      @laterals << slices[@laterals.size]
    else # operator
      length_type = @contents.first.to_i

      if length_type == 0 # number of bits 
        number_of_bits = @contents[1..15].join.to_i(2)
        sub_packets = @contents[16..16+number_of_bits-1].join

        @lengths = @contents[0..15].join
        
        while sub_packets.size > 0
          packet = Packet.new(sub_packets)
          @packets << packet
          sub_packets = sub_packets.sub(packet.representation, '')
        end

      else # number of packets
        number_of_packets = @contents[1..11].join.to_i(2)
        sub_packets = @contents[12..].join
        @lengths = @contents[0..11].join
        while @packets.size < number_of_packets
          packet = Packet.new(sub_packets)
          @packets << packet
          sub_packets = sub_packets.sub(packet.representation, '')
        end
      end
    end
  end

  def version_sum
    @version + @packets.map(&:version_sum).sum
  end

  def representation 
      @binary[0..5] + @laterals.join + @lengths + @packets.map { _1.representation }.join
  end

  def value 
    values = @packets.map(&:value)

    case @type_id
    when 0
      return values.sum
    when 1
      return values.inject(:*)
    when 2
      return values.min
    when 3
      return values.max
    when 4
      return @laterals.map { |x| x[1..] }.join.to_i(2)
    when 5
      return (values[0] > values[1]) ? 1 : 0 
    when 6
      return (values[0] < values[1]) ? 1 : 0 
    when 7
      return (values[0] == values[1]) ? 1 : 0 
    end
  end
end

packet = Packet.new(binary)

p packet.version_sum
p packet.value



