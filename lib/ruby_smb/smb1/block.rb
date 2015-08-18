module RubySMB
module SMB1
module Block
  autoload :SMB_Header,     'ruby_smb/smb1/packet/smb_header'
  autoload :SMB_Parameters, 'ruby_smb/smb1/packet/smb_parameters'
  autoload :SMB_Data,       'ruby_smb/smb1/packet/smb_data'
  autoload :SMB_Packet,     'ruby_smb/smb1/packet/smb_packet'

  def for(composite_class, template)
    composite_class.new template
  end
end
end
end
