module RubySMB
module SMB1
module Packet
  # autoload :SMBParameterBlock, 'ruby_smb/smb1/packet/smb_parameter_block'

class << self
  def for(command)
    header = {
               protocol: "\xFFSMB",
                command: "\x72",
                 status: "\x00\x00\x00\x00",
                  flags: "\x00",
                 flags2: "\x00\x00",
               pid_high: "\x00\x00",
      security_features: "\x00\x00\x00\x00\x00\x00\x00\x00",
               reserved: "\x00\x00",
                    tid: "\x00\x00",
                pid_low: "\x00\x00",
                    uid: "\x00\x00",
                    mid: "\x00\x00"
    }.values.join

    params = {
      word_count: "\x00"
    }.values.join

    data = {
      byte_count: "\x0A",
      dialects:   ["NT LM 0.12"]
    }.values.join

    header + params + data
  end
end


end
end
end
