module RubySMB
module SMB1
module Packet
  autoload :SMB_Header, 'ruby_smb/smb1/packet/smb_header'

  class << self
    def for_request(command, options={})
      # Command.for(command, options)
    end
  end

end
end
end
