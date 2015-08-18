module RubySMB
module SMB1
module Request
class  SMB_COM_NEGOTIATE < Command
  def child_initialize(params={})
    @n_bytes_dialects = params[:n_bytes_dialects]
    @dialects         = params[:dialects]
    create_packet(params)

        @params = {
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
        byte_count: params[:n_bytes_dialects],
          dialects: params[:dialects_value]
      }
    }

    # create packet
  end
end
end
end
end
