module RubySMB
module SMB1
module Command
class  SMB_COM_NEGOTIATE

  def packet
    {
      # smb_header
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
                    mid: { n_bytes: 2, value: "\x00"    },
      # smb_parameters
              wordcount: { n_bytes: 1, value: "\x00"    },
                  words: { n_bytes: 0, value: ''        },

      # smb_data
              bytecount: { n_bytes: 2,  value: "\xA0"       },
          buffer_format: { n_bytes: 1,  value: "\x02"       },
         dialect_string: { n_bytes: 10, value: "NT LM 0.12" },
    }
  end

  def n_bytes(smb_block)
    fields        = smb_block.keys
    field_lengths = fields.map { |field| smb_block[field][:n_bytes] }
    n_bytes       = field_lengths.reduce(:+)
  end

  def to_binary_s
    fields        = packet.values
    field_values  = fields.map do |f|
                      n_bytes       = f[:n_bytes]
                      n_bytes_value = f[:value].bytes.count
                      padding = "\x00" * (n_bytes - n_bytes_value)
                      f[:value] + padding
                    end

    binary_string = field_values.reduce(:+).bytes.pack('C*')
  end
end
end
end
end
