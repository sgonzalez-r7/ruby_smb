module RubySMB
module SMB1
module Request
  autoload :Command,           'ruby_smb/smb1/request/command'
  autoload :SMB_COM_NEGOTIATE, 'ruby_smb/smb1/request/smb_com_negotiate'

  class << self
    def for_request(command, options={})
      # Command.for(command, options)
    end
  end

end
end
end
