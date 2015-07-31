module RubySMB
  module SMB1
    module Packet
      module NegotiateCommand
        # This class represents the custom DataBlock data for a NegotiateRequest.
        # This is just an array of SMB Dialect Structures.
        # [2.2.4.52.1 Request](https://msdn.microsoft.com/en-us/library/ee441572.aspx)
        class RequestDataBlock < BitStruct::Vector
          unsigned :buffer_format,     8, "Buffer Format Type"
          text     :dialect_string,  320, "Supported Dialect"

          Dialect = struct_class
        end
      end
    end
  end
end
