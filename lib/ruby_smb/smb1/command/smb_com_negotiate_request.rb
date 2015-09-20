module RubySMB
module SMB1
module Command
class  SMB_COM_NEGOTIATE_REQUEST
  attr_reader   :params
  attr_accessor :packet

  def initialize(params:{})
    @params = default_params.merge(params)
    build
  end

  def build
    @packet = to_binary_s
  end

  def default_params
    {
      #smb_header
               protocol: { n_bytes:  4,  value:  "\xFFSMB"    },
                command: { n_bytes:  1,  value:  "\x72"       },
                 status: { n_bytes:  4,  value:  "\x00"       },
                  flags: { n_bytes:  1,  value:  "\x18"       },
                 flags2: { n_bytes:  2,  value:  "\x48\x01"   },
               pid_high: { n_bytes:  2,  value:  "\x00"       },
      security_features: { n_bytes:  8,  value:  "\x00"       },
               reserved: { n_bytes:  2,  value:  "\x00"       },
                    tid: { n_bytes:  2,  value:  "\xFF\xFF"   },
                pid_low: { n_bytes:  2,  value:  "\x00"       },
                    uid: { n_bytes:  2,  value:  "\x00"       },
                    mid: { n_bytes:  2,  value:  "\x00"       },

      #smb_parameters
             word_count: { n_bytes:  1,  value:  "\x00"       },
                  words: { n_bytes:  0,  value:  ""           },

      #smb_data
             byte_count: { n_bytes:  2,  value: "\xA0\x00"    },
               dialects: { n_bytes: 34,  value: "\x02NT LM 0.12\x00\x02SMB 2.002\x00\x02SMB 2.???\x00"  },
    }
  end

  def field(name)
    fields.select{ |field| field[:name] == name }.first
  end

  def fields
    structure
  end

  def n_bytes_actual
    normalize(packet).bytes.count
  end

  def n_bytes_allocated
    fields.map{ |f| f[:n_bytes] }.reduce(:+)
  end

  # does belong in a mixin?
  def normalize(string)
    string.bytes.pack('C*')
  end

  def parse(string_io)
    fields.each do |f|
      buffer = []
      f[:n_bytes].times { buffer << string_io.getbyte }
      f[:value] = buffer.pack('C*')
      ap f[:value]
    end
  end

  def structure
    p = params
    [
      # smb_header
      { name: :protocol,           n_bytes: p[:protocol][:n_bytes],          value: p[:protocol][:value] },
      { name: :command,            n_bytes: p[:command][:n_bytes] ,          value: p[:command][:value] },
      { name: :status,             n_bytes: p[:status][:n_bytes],            value: p[:status][:value] },
      { name: :flags,              n_bytes: p[:flags][:n_bytes],             value: p[:flags][:value] },
      { name: :flags2,             n_bytes: p[:flags2][:n_bytes],            value: p[:flags2][:value] },
      { name: :pid_high,           n_bytes: p[:pid_high][:n_bytes],          value: p[:pid_high][:value] },
      { name: :security_features,  n_bytes: p[:security_features][:n_bytes], value: p[:security_features][:value] },
      { name: :reserved,           n_bytes: p[:reserved][:n_bytes],          value: p[:reserved][:value] },
      { name: :tid,                n_bytes: p[:tid][:n_bytes],               value: p[:tid][:value] },
      { name: :pid_low,            n_bytes: p[:pid_low][:n_bytes],           value: p[:pid_low][:value] },
      { name: :uid,                n_bytes: p[:uid][:n_bytes],               value: p[:uid][:value] },
      { name: :mid,                n_bytes: p[:mid][:n_bytes],               value: p[:mid][:value] },

      # smb_parameters
      { name: :word_count,         n_bytes: p[:word_count][:n_bytes],        value: p[:word_count][:value] },
      { name: :words,              n_bytes: p[:words][:n_bytes],             value: p[:words][:value] },

      # smb_data
      { name: :byte_count,         n_bytes: p[:byte_count][:n_bytes],        value: p[:byte_count][:value] },
      { name: :dialects,           n_bytes: p[:dialects][:n_bytes],          value: p[:dialects][:value] },
    ]
  end

  def to_binary_s
    fields.map do |f|
                 n_bytes_allocated = f[:n_bytes]
                 n_bytes_actual    = normalize(f[:value]).bytes.count

                 if n_bytes_allocated > n_bytes_actual
                   padding = normalize("\x00" * (n_bytes_allocated - n_bytes_actual))
                 else
                   padding = ""
                 end

                 normalize(f[:value]) + normalize(padding)
               end.reduce(:+).bytes.pack('C*')
  end

  def validate
    validate_actual_gt_allocated
  end

  def validate_actual_gt_allocated
    if (n_bytes_actual > n_bytes_allocated)
      raise 'Actual packet size is larger than the allocated size'
    end
  end
end
end
end
end
