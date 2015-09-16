require 'spec_helper'

module RubySMB
module SMB1
module Command
RSpec.describe SMB_COM_NEGOTIATE do
  describe '#smb_header' do
    it 'is 32 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header

      expect(smb_com_negotiate.n_bytes(smb_header)).to eql 32
    end
  end

  describe 'protocol field' do
    it 'is 4 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      protocol          = smb_header[:protocol]

      expect(protocol[:n_bytes]).to eql 4
    end
  end

  describe 'command field' do
    it 'is 1 byte in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      command           = smb_header[:command]

      expect(command[:n_bytes]).to eql 1
    end
  end


  describe 'status field' do
    it 'is 4 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      status            = smb_header[:status]

      expect(status[:n_bytes]).to eql 4
    end
  end

  describe 'flags field' do
    it 'is 1 byte in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      flags             = smb_header[:flags]

      expect(flags[:n_bytes]).to eql 1
    end
  end

  describe 'flags2 field' do
    it 'is 2 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      flags2            = smb_header[:flags2]

      expect(flags2[:n_bytes]).to eql 2
    end
  end


  describe 'pid_high field' do
    it 'is 2 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      pid_high          = smb_header[:pid_high]

      expect(pid_high[:n_bytes]).to eql 2
    end
  end

  describe 'security_features field' do
    it 'is 8 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      security_features = smb_header[:security_features]

      expect(security_features[:n_bytes]).to eql 8
    end
  end

  describe 'reserved field' do
    it 'is 2 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      reserved          = smb_header[:reserved]

      expect(reserved[:n_bytes]).to eql 2
    end
  end

  describe 'tid field' do
    it 'is 2 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      tid               = smb_header[:tid]

      expect(tid[:n_bytes]).to eql 2
    end
  end

  describe 'pid_low field' do
    it 'is 2 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      pid_low           = smb_header[:pid_low]

      expect(pid_low[:n_bytes]).to eql 2
    end
  end

  describe 'uid field' do
    it 'is 2 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      uid              = smb_header[:uid]

      expect(uid[:n_bytes]).to eql 2
    end
  end

  describe 'mid field' do
    it 'is 2 bytes in length' do
      smb_com_negotiate = SMB_COM_NEGOTIATE.new
      smb_header        = smb_com_negotiate.smb_header
      mid               = smb_header[:mid]

      expect(mid[:n_bytes]).to eql 2
    end
  end

end
end
end
end
