# Helper module that extract position attribute.
module Positioned
  @@positions = {}

  def self.positions
    @@positions
  end

  def position
    pos = Positioned.positions[self]
    if pos == nil
      str = "position accessed but not set, "
      str += "#{self.object_id.to_s(16)}\n"
      raise str + "for #{self.class} byte_length #{self.byte_length if self.respond_to?(:byte_length)} for #{self.inspect[0...100]}"
    end
    pos
  end
  def set_position( pos )
    raise "Position must be number not :#{pos}:" unless pos.is_a?(Numeric)
    # resetting of position used to be error, but since relink and dynamic instruction size it is ok.
    # in measures (of 32)
    #puts "Setting #{pos} for #{self.class}"
    old = Positioned.positions[self]
    if old != nil and ((old - pos).abs > 10000)
      raise "position set again #{pos}!=#{old} for #{self}"
    end
    Positioned.positions[self] = pos
  end


end
