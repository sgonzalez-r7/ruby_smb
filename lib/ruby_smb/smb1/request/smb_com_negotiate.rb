module RubySMB
module SMB1
module Request
class  SMB_COM_NEGOTIATE < Command
  attr_accessor :n_bytes_dialects, :dialects, :packet_class

  def child_initialize(params={})
    @n_bytes_dialects = params[:n_bytes_dialects]
    @dialects         = params[:dialects]
    @packet_class     = params[:packet_class] || SMB1::Packet
    @packet           = packet_class.new template(params)
  end

  def template(params)
    {
      smb_header: {
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
      },

      smb_parameters: {
        word_count: "\x00"
      },

      smb_data: {
        byte_count: n_bytes_dialects,
          dialects: dialects_value
      }
    }
  end

end
end
end
end
