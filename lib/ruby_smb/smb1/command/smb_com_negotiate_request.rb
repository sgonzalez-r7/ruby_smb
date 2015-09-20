module RubySMB
module SMB1
module Command
class  SMB_COM_NEGOTIATE_REQUEST
  attr_reader :packet, :params

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

  def structure
    [
      # smb_header
      { name: :protocol,           n_bytes: params[:protocol][:n_bytes],          value: params[:protocol][:value] },
      { name: :command,            n_bytes: params[:command][:n_bytes] ,          value: params[:command][:value] },
      { name: :status,             n_bytes: params[:status][:n_bytes],            value: params[:status][:value] },
      { name: :flags,              n_bytes: params[:flags][:n_bytes],             value: params[:flags][:value] },
      { name: :flags2,             n_bytes: params[:flags2][:n_bytes],            value: params[:flags2][:value] },
      { name: :pid_high,           n_bytes: params[:pid_high][:n_bytes],          value: params[:pid_high][:value] },
      { name: :security_features,  n_bytes: params[:security_features][:n_bytes], value: params[:security_features][:value] },
      { name: :reserved,           n_bytes: params[:reserved][:n_bytes],          value: params[:reserved][:value] },
      { name: :tid,                n_bytes: params[:tid][:n_bytes],               value: params[:tid][:value] },
      { name: :pid_low,            n_bytes: params[:pid_low][:n_bytes],           value: params[:pid_low][:value] },
      { name: :uid,                n_bytes: params[:uid][:n_bytes],               value: params[:uid][:value] },
      { name: :mid,                n_bytes: params[:mid][:n_bytes],               value: params[:mid][:value] },

      # smb_parameters
      { name: :word_count,         n_bytes: params[:word_count][:n_bytes],        value: params[:word_count][:value] },
      { name: :words,              n_bytes: params[:words][:n_bytes],             value: params[:words][:value] },

      # smb_data
      { name: :byte_count,         n_bytes: params[:byte_count][:n_bytes],        value: params[:byte_count][:value] },
      { name: :dialects,           n_bytes: params[:dialects][:n_bytes],          value: params[:dialects][:value] },
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
