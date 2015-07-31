module RubySMB
  module SMB1
    module Packet

      # Naemspace for all packets and structures related to the the SMB1
      # Negotiate command.
      module NegotiateCommand
        autoload :RequestDataBlock, 'ruby_smb/smb1/packet/negotiate_command/request_data_block'
        autoload :Request, 'ruby_smb/smb1/packet/negotiate_command/request'
      end
    end
  end
end