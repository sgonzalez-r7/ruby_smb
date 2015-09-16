module RubySMB
module SMB1
module Command
class  SMB_COM_NEGOTIATE

  def smb_header
    {
               protocol: { n_bytes: 4, value: "\xFFSMB" },
                command: { n_bytes: 1, value: "\x72"    },
                 status: { n_bytes: 4, value: "\x00"    },
                  flags: { n_bytes: 1, value: "\x00"    },
                 flags2: { n_bytes: 2, value: "\x00"    },
               pid_high: { n_bytes: 2, value: "\x00"    },
      security_features: { n_bytes: 8, value: "\x00"    },
               reserved: { n_bytes: 2, value: "\x00"    },
                    tid: { n_bytes: 2, value: "\x00"    },
                pid_low: { n_bytes: 2, value: "\x00"    },
                    uid: { n_bytes: 2, value: "\x00"    },
                    mid: { n_bytes: 2, value: "\x00"    }
    }
  end

  def n_bytes(smb_block)
    fields        = smb_block.keys
    field_lengths = fields.map { |field| smb_block[field][:n_bytes] }
    n_bytes       = field_lengths.reduce(:+)
  end

  def to_binary_s(smb_block)
    fields        = smb_block.keys
    field_bytes   = fields.map do |field|
                      length_field = smb_block[field][:n_bytes]
                      length_value = smb_block[field][:value].bytes.length
                      expansion    = length_field - length_value + 1

                      (smb_block[field][:value] * expansion).bytes.pack('C*')
                    end

    binary_string = field_bytes.reduce(:+)
  end
end
end
end
end
