module RubySMB
module SMB1
module Block
class  SMB_Packet < SMB1::Field::Composite
  def initialize_block(params)
    add Block.for(SMB_Header)
    add Block.for(SMB_Parameters)
    add Block.for(SMB_Data)
    add Block.for(SMB_Packet)
  end
end
end
end
end
