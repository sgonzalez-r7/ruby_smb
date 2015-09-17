module RubySMB
module SMB1
module Command
class  SMB_COM_NEGOTIATE

  # command has
  def params
    {
      # smb_header
               protocol: "\xFFSMB",
                command: "\x72",
                 status: "\x00",
                  flags: "\x00",
                 flags2: "\x00",
               pid_high: "\x00",
      security_features: "\x00",
               reserved: "\x00",
                    tid: "\x00",
                pid_low: "\x00",
                    uid: "\x00",
                    mid: "\x00",

      # smb_parameters
             word_count: "\x00",
                  words: "",

      # smb_data,
             byte_count:  "\xA0",
          buffer_format:  "\x02",
         dialect_string:  "NT LM 0.12",
    }
  end


  def packet
    {
      # smb_header
               protocol: { n_bytes:  4, value: params[:protocol]          },
                command: { n_bytes:  1, value: params[:command]           },
                 status: { n_bytes:  4, value: params[:status]            },
                  flags: { n_bytes:  1, value: params[:flags]             },
                 flags2: { n_bytes:  2, value: params[:flags2]            },
               pid_high: { n_bytes:  2, value: params[:pid_high]          },
      security_features: { n_bytes:  8, value: params[:security_features] },
               reserved: { n_bytes:  2, value: params[:reserved]          },
                    tid: { n_bytes:  2, value: params[:tid]               },
                pid_low: { n_bytes:  2, value: params[:pid_low]           },
                    uid: { n_bytes:  2, value: params[:uid]               },
                    mid: { n_bytes:  2, value: params[:mid]               },
      # smb_parameters
             word_count: { n_bytes:  1, value: params[:word_count]        },
                  words: { n_bytes:  0, value: params[:words]             },

      # smb_data
             byte_count: { n_bytes:  2, value: params[:byte_count]        },
          buffer_format: { n_bytes:  1, value: params[:buffer_format]     },
         dialect_string: { n_bytes: 10, value: params[:dialect_string]    },
    }
  end

  # command does these things

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
