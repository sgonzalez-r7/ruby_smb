module RubySMB
module SMB1
module Block
class  SMB_Header < SMB1::Field::Composite
  def initialize_block(params)
    add SMB1::Field::Leaf.new(protocol)
    add SMB1::Field::Leaf.new(params)
  end
end
end
end
