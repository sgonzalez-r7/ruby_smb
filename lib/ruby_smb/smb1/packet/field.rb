module RubySMB
module SMB1
module Packet
class  Field
  attr_accessor :name

  def initialize(&block)
    yield self if block_given?
  end
end
end
end
end
