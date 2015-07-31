module RubySMB
  module SMB1
    module Packet
      module NegotiateCommand

        # Represents a SMB1 Negotiate request packet.
        # [2.2.4.52.1 Request](https://msdn.microsoft.com/en-us/library/ee441572.aspx)
        class Request < BitStruct
          nest :smb_header, RubySMB::SMB1::Packet::SMBHeader, 'SMB Header'
          nest :smb_parameters, RubySMB::SMB1::Packet::SMBParameterBlock, 'SMB Parameter'
          nest :smb_data, RubySMB::SMB1::Packet::SMBDataBlock , 'SMB Data'

          def initialize(value=nil)
            super
            # Set specific header values
            header = self.smb_header
            header.command = RubySMB::SMB1::COMMANDS[:SMB_COM_NEGOTIATE]
            self.smb_header = header
          end

          def set_dialects(dialects=[])
            raise ArgumentError, 'Must be an Array of Dialects' unless dialects.kind_of? Enumerable
            bad_dialect = dialects.detect{ |dialect| !dialect.is_a? RubySMB::SMB1::Packet::NegotiateCommand::RequestDataBlock::Dialect }

          end
        end
      end
    end
  end
end