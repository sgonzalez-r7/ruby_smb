require 'spec_helper'

module RubySMB
module SMB1
RSpec.describe Packet do
  describe '.for(:SMB_COM_NEGOTIATE)' do
    let(:packet) do
      {
        header: {
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
        params: "",
        data:   "",
    }
    end


    it 'generates the packet for SMB_COM_NEGOTIATE' do
      header = packet[:header].values.join
      expect(Packet.for(:SMB_COM_NEGOTIATE)).to eql header
    end
  end
end
end
end

