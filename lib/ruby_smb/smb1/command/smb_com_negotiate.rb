module RubySMB
module SMB1
module Command
class  SMB_COM_NEGOTIATE

  def smb_header
    {
               protocol: { n_bytes: 4 },
                command: { n_bytes: 1 },
                 status: { n_bytes: 4 },
                  flags: { n_bytes: 1 },
                 flags2: { n_bytes: 2 },
               pid_high: { n_bytes: 2 },
      security_features: { n_bytes: 8 },
               reserved: { n_bytes: 2 },
                    tid: { n_bytes: 2 },
                pid_low: { n_bytes: 2 },
                    uid: { n_bytes: 2 },
                    mid: { n_bytes: 2 }
    }
  end

  def n_bytes(smb_block)
    fields        = smb_block.keys
    field_lengths = fields.map { |field| smb_block[field][:n_bytes] }
    n_bytes       = field_lengths.reduce(:+)
  end

end
end
end
end
