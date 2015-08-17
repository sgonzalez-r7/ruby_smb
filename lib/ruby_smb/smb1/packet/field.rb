module RubySMB
module SMB1
module Packet
class  Field
  attr_accessor :n_bytes

  def initialize(n_bytes: 0)
    @n_bytes = n_bytes
  end

  def build
    raise StandardError,
          'Method build not implemented for abstract class'
  end
end
end
end
end
