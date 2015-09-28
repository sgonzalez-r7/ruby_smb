require 'spec_helper'

module RubySMB
module SMB1
module Command
RSpec.describe SMB_COM_NEGOTIATE_REQUEST do
  def normalize(string)
    string.bytes.pack('C*')
  end

  let(:default_fields_spec) do
    [ # smb_header
      { name:           :protocol,   n_bytes_spec:  4,
                                            value: "\xFFSMB",
                                      to_binary_s: "\xFFSMB"                },

      { name:            :command,   n_bytes_spec:  1,
                                            value: "\x72",
                                      to_binary_s: "\x72"                   },

      { name:             :status,   n_bytes_spec:  4,
                                            value: "\x00",
                                      to_binary_s: "\x00\x00\x00\x00"       },

      { name:              :flags,   n_bytes_spec:  1,
                                            value: "\x18",
                                      to_binary_s: "\x18"                   },

      { name:             :flags2,   n_bytes_spec:  2,
                                            value: "\x48\x01",
                                      to_binary_s: "\x48\x01"               },

      { name:           :pid_high,   n_bytes_spec:  2,
                                            value: "\x00",
                                      to_binary_s: "\x00\x00"               },

      { name:  :security_features,   n_bytes_spec:  8,
                                            value: "\x00",
                                      to_binary_s: "\x00\x00\x00\x00" +
                                                   "\x00\x00\x00\x00"       },

      { name:           :reserved,   n_bytes_spec:  2,
                                            value: "\x00",
                                      to_binary_s: "\x00\x00"               },

      { name:                :tid,   n_bytes_spec:  2,
                                            value: "\xFF\xFF",
                                      to_binary_s: "\xFF\xFF"               },

      { name:            :pid_low,   n_bytes_spec:  2,
                                            value: "\x00",
                                      to_binary_s: "\x00\x00"               },

      { name:                :uid,   n_bytes_spec:  2,
                                            value: "\x00",
                                      to_binary_s: "\x00\x00"               },

      { name:                :mid,   n_bytes_spec:  2,
                                            value: "\x00",
                                      to_binary_s: "\x00\x00"               },

      # smb_parn_bytes_spec
      { name:         :word_count,   n_bytes_spec:  1,
                                            value: "\x00",
                                      to_binary_s: "\x00"                   },

      { name:              :words,   n_bytes_spec:  0,
                                            value: "",
                                      to_binary_s: ""                       },

      # sn_bytes_spec
      { name:         :byte_count,   n_bytes_spec:  2,
                                            value: "\xA0\x00",
                                      to_binary_s: "\xA0\x00"               },

      { name:           :dialects,   n_bytes_spec: 34,
                                            value: "\x02NT LM 0.12\x00" +
                                                   "\x02SMB 2.002\x00"  +
                                                   "\x02SMB 2.???\x00",

                                      to_binary_s: "\x02NT LM 0.12\x00" +
                                                   "\x02SMB 2.002\x00"  +
                                                   "\x02SMB 2.???\x00"      }
    ]
  end

  context 'SMB Specification' do
    let(:command) { SMB_COM_NEGOTIATE_REQUEST.new }

    describe '#fields.count' do
      it 'honors the SMB Spec' do
        expect(command.fields.count).to eql default_fields_spec.count
      end
    end

    describe '#fields[0] (protocol)' do
      let(:i)             { 0                      }
      let(:command_field) { command.fields[i]      }
      let(:spec_field)    { default_fields_spec[i] }

      it "has attr          name: :protocol" do
        expect(command_field[:name]).to \
           eql    spec_field[:name]
      end

      it 'has attr  n_bytes_spec: 4' do
        expect(command_field[:n_bytes_spec]).to \
           eql    spec_field[:n_bytes_spec]
      end


      it 'has attr         value: "\xFFSMB"' do
        expect(command_field[:value]).to \
           eql    spec_field[:value]
      end
    end

    describe '#fields[1] (command)' do
      let(:i)             { 0                      }
      let(:command_field) { command.fields[i]      }
      let(:spec_field)    { default_fields_spec[i] }

      it "has attr          name: command" do
        expect(command_field[:name]).to \
           eql    spec_field[:name]
      end

      it 'has attr  n_bytes_spec: 1' do
        expect(command_field[:n_bytes_spec]).to \
           eql    spec_field[:n_bytes_spec]
      end


      it 'has attr         value: "\x72"' do
        expect(command_field[:value]).to \
           eql    spec_field[:value]
      end
    end



  end

  context 'DEFAULT field attributes' do
    describe '#fields[3]' do
      it 'has attr          name: :flags'
      it 'has attr  n_bytes_spec: 1'
      it 'has attr         value: "\x18"'
    end


  end


end
end
end
end
