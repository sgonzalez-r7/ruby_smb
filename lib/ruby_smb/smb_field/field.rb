module RubySMB
module SMB_Field
class  Field
  attr_accessor :name

  def initialize(&block)
    yield self if block_given?
  end
end
end
end