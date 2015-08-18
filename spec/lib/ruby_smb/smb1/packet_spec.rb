require 'spec_helper'

module RubySMB
module SMB1
RSpec.describe Packet do
  describe '.for(:SMB_COM_NEGOTIATE)' do
    let(:dialects)         { ["West Coast", "East Coast"] }
    let(:dialects_value)   { dialects.join                }
    let(:n_bytes_dialects) { dialects_value.bytes.size    }

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
          byte_count: n_bytes_dialects,
            dialects: dialects_value
        }
      }
    end

    it 'generates the packet for SMB_COM_NEGOTIATE' do
      header = packet[:header].values.join
      params = packet[:params].values.join
      data   = packet[:data].values.join

      packet_spec = header + params + data

      generated_packet = Packet.for_request(:SMB_COM_NEGOTIATE,
                                    dialects: dialects)

      # expect(generated_packet).to eql packet_spec

      ap generated_packet
    end
  end
end
end
end

