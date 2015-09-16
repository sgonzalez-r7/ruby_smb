require 'spec_helper'

module RubySMB
module SMB1
module Command
RSpec.describe SMB_COM_NEGOTIATE do
  describe '#smb_header' do
    it 'is 32-bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new

      expect(smb_com_negotiate.n_bytes_smb_header).to eql 32
    end
  end
end
end
end
end
