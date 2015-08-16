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

        params: {
          word_count: "\x00"
        },

        data: {
          byte_count: "\x0A",
            dialects: ["NT LM 0.12"]
        }
    }
    end


    it 'generates the packet for SMB_COM_NEGOTIATE' do
      header = packet[:header].values.join
      params = packet[:params].values.join
      data   = packet[:data].values.join

      packet = header + params + data
      expect(Packet.for(:SMB_COM_NEGOTIATE)).to eql packet
    end
  end
end
end
end

