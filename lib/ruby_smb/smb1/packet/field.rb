module RubySMB
module SMB1
module Packet
class  Field
  attr_accessor :name
  attr_accessor :type
  attr_accessor :value

  def initialize(&block)
    @name    = ''
    @type    = nil
    @value   = ''

    yield self if block_given?
  end

  def n_bytes
    value.bytesize
  end

end
end
end
end
